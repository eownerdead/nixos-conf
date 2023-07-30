{ config, pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/enable-flake.nix
    ../common/auto-gc.nix
    ../common/doas.nix
    ../common/doh.nix
  ];

  nix = {
    settings.auto-optimise-store = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "home-server";
    useDHCP = false;
    nameservers = [ "192.168.1.1" ];
    defaultGateway = "192.168.1.1";
    interfaces = {
      "enp2s0".ipv4.addresses = [
        {
          address = "192.168.1.100";
          prefixLength = 24;
        }
      ];
    };
    firewall.allowedTCPPorts = [
      80 # nginx
      9418 # git
    ];
  };

  i18n.defaultLocale = "ja_JP.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  users.users.noobuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment = {
    systemPackages = with pkgs; [
      wget
    ];
    # https://github.com/NixOS/nixpkgs/issues/93116
    memoryAllocator.provider = "libc";
  };

  programs.git.enable = true;

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    snowflake-proxy.enable = true;

    ddclient = {
      enable = true;
      server = "update.dedyn.io";
      username = "null.dedyn.io";
      domains = [ "null.dedyn.io" ];
      use = "cmd, cmd='${pkgs.curl}/bin/curl https://checkipv6.dedyn.io/'";
      passwordFile = "/etc/dedyn_token";
      ipv6 = true;
    };

    nginx = {
      enable = true;
      virtualHosts = {
        "null.dedyn.io".basicAuthFile = "/etc/nginx/.htpasswd";
        "git.null.dedyn.io".locations."/".proxyPass = "http://0.0.0.0:3000";
      };
    };

    gitea = {
      enable = true;
      package = pkgs.forgejo;
      # domain = "git.null.dedyn.io";
      database.type = "mysql";
    };
  };

  system.stateVersion = "22.05";
}
