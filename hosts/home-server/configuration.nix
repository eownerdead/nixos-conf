{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/enable-flake.nix
    ../common/auto-gc.nix
    ../common/use-local-nix.nix
    ../common/doas.nix
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

    nginx = {
      enable = true;
      virtualHosts."home-server.local".locations = {
        "/yacy/" = {
          proxyPass = "http://127.0.0.1:8090/";
          extraConfig = ''
            proxy_redirect default;
          '';
        };
      };
    };
  };

  system.stateVersion = "22.05";
}
