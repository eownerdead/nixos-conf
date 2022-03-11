{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # Make ready for nix flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;

    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/";
  };


  console = {
    # font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "nixos";
    hostId = "8556b001";
    useDHCP = false;
    interfaces.enp42s0.useDHCP = true;
  };

  services = {
    zfs = {
      trim.enable = true;
      autoScrub = {
        enable = true;
        pools = [ "rpool" ];
      };
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    gnome = {
      chrome-gnome-shell.enable = true;
      core-developer-tools.enable = true;
    };
    printing.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "jp106";
  # services.xserver.xkbOptions = "eurosign:e";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.noobuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" "adbusers" ];
  };

  environment = {
    gnome.excludePackages = [ pkgs.gnome-builder ];
    systemPackages = with pkgs; [
      wget
      home-manager
      chrome-gnome-shell
      ntfs3g
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };

  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };
  };

  system.stateVersion = "21.11";
}
