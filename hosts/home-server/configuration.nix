{ config, pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/enable-flake.nix
    ../common/auto-gc.nix
    ../common/doas.nix
    ../common/doh.nix

    ../home-server/gitea.nix
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
      80 # http
      443 # https
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

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedZstdSettings = true;
      recommendedBrotliSettings = true;
      virtualHosts = {
        "null.dedyn.io" = { };
        # "www.null.dedyn.io" = { };
      };
    };
  };

  system.stateVersion = "22.05";
}
