{ config, pkgs, nixpkgs, ... }:
let sops = config.sops.secrets;
in {
  imports = [
    ./hardware-configuration.nix
    ../../nixos

    ../common/sops.nix
    ../common/global-pkgs.nix
    ../common/hardened.nix
  ];

  eownerdead = {
    recommended = true;
    flatpak = true;
    nvidia = true;
    sound = true;
    zfs = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;

    supportedFilesystems = [ "btrfs" "exfat" "ext4" "ntfs" "vfat" "xfs" "zfs" ];
    kernelModules = [ "btrfs" "exfat" "ext4" "ntfs3" "vfat" "xfs" ];
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "nixos";
    hostId = "8556b001";
    networkmanager.enable = true;
  };

  services = {
    printing.enable = true;
    avahi.nssmdns = true;
    udisks2.enable = true;
    gvfs.enable = true;
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  };

  programs.wireshark.enable = true;

  hardware.opengl.enable = true;

  users.users.noobuser = {
    isNormalUser = true;
    passwordFile = sops.noobuserPassword.path;
    extraGroups = [ "wheel" "wireshark" "adbusers" ];
  };

  environment = {
    systemPackages = with pkgs; [ wget home-manager ntfs3g cachix unzip glib ];
  };

  i18n.defaultLocale = "ja_JP.UTF-8";

  fonts.fonts = with pkgs; [ noto-fonts-cjk-sans noto-fonts-cjk-serif ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd.enable = true;
    waydroid.enable = true;
  };

  system.stateVersion = "21.11";
}
