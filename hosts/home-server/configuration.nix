{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
    autoOptimiseStore = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "home-server";
    useDHCP = false;
    nameservers = [ "192.168.3.1" ];
    defaultGateway = "192.168.3.1";
    interfaces = {
      "enp2s0".ipv4.addresses = [
        {
          address = "192.168.3.100";
          prefixLength = 24;
        }
      ];
    };
    firewall.enable = false;
    firewall.allowedTCPPorts = [ 80 ]; # nextcloud
  };

  i18n.defaultLocale = "ja_JP.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  users.users.user1 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.git.enable = true;

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };

    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    # https://discourse.nixos.org/t/minimal-working-nextcloud-config/9316
    nextcloud = {
      enable = true;
      hostName = "home-server.local";
      config = {
        extraTrustedDomains = [ "*" ];
        dbtype = "mysql";
        dbport = 3306;
        dbpassFile = "/etc/nextcloud_dbpass.txt";
        adminpassFile = "/etc/nextcloud_adminpass.txt";
      };
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [
        "nextcloud"
      ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensurePermissions = {
            "nextcloud.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };
  };

  system.stateVersion = "21.11";
}
