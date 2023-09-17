{ config, pkgs, nixpkgs, ... }:
let sops = config.sops.secrets;
in {
  imports = [
    ./hardware-configuration.nix
    ../../nixos

    ../common/sops.nix
    ./nginx.nix
    ./gitea.nix
    ./actions.nix
  ];

  sops.defaultSopsFile = ./sops.yaml;

  eownerdead = {
    recommended = true;
    doas = false;
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
      "enp2s0".ipv4.addresses = [{
        address = "192.168.1.100";
        prefixLength = 24;
      }];
    };
    firewall.allowedTCPPorts = [
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY59B9RvaQW314iSWSIi9EWO+J6aNWImXoeZyLwQzSC openpgp:0x5CA54D63"
    ];
    extraGroups = [ "wheel" ];
  };

  environment = {
    systemPackages = with pkgs; [ wget ];
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
  };

  system.stateVersion = "22.05";
}
