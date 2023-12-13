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
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        X11Forwarding = true;
      };
    };
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
    printing.enable = true;
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY59B9RvaQW314iSWSIi9EWO+J6aNWImXoeZyLwQzSC openpgp:0x5CA54D63"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5bTpOOFrIF3IqOZqUsJUTziQduAzXOpNfsFM4Yat8F a@DESKTOP-R9IE7K2"
    ];
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
