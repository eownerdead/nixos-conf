{ config, pkgs, nixpkgs, ... }:
let sops = config.sops.secrets;
in {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    ../common/sops.nix
    ../global-pkgs.nix
  ];

  eownerdead = {
    recommended = true;
    sound = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.consoleMode = "0";
    };
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "slate";
    useNetworkd = true;
    wireless = {
      enable = true;
      userControlled.enable = true; # wpa_cli
      allowAuxiliaryImperativeNetworks = true;
    };
  };

  hardware = {
    opengl.enable = true;
    enableRedistributableFirmware = true; # wireless lan
  };

  i18n.defaultLocale = "ja_JP.UTF-8";

  users.users.eownerdead = {
    isNormalUser = true;
    password = "test";
    extraGroups = [ "wheel" ];
  };

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        domain = true;
        addresses = true;
      };
    };
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  };

  system.stateVersion = "22.11";
}
