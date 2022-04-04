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
    interfaces.enp2s0.useDHCP = true;
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

    # https://discourse.nixos.org/t/minimal-working-nextcloud-config/9316
    nextcloud = {
      enable = true;
      hostName = "10.50.0.2";
      config = {
        extraTrustedDomains = [ "192.168.*" ];
        dbpassFile = "/etc/nextcloud_dbpass.txt";
        adminpassFile = "/etc/nextcloud_adminpass.txt";
      };
    };
  };

  system.stateVersion = "21.11";
}
