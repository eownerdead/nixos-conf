{ config, pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/enable-flake.nix
    ../common/auto-gc.nix
    ../common/doas.nix
    ../common/nvidia.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
    kernelPackages = pkgs.linuxPackages_hardened;

    plymouth.enable = true;

    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/";
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "nixos";
    hostId = "8556b001";
    networkmanager.enable = true;
  };

  services = {
    zfs = {
      trim = {
        enable = true;
        interval = "monthly";
      };
      autoScrub = {
        enable = true;
        pools = [ "rpool" ];
        interval = "weekly";
      };
    };
    printing.enable = true;
    avahi.nssmdns = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
    flatpak.enable = true;
  };

  # Required by flatpak.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs = {
    git = {
      enable = true;
      config = {
        user = {
          email = "you@example.com";
          name = "Your Name";
        };
      };
    };
    wireshark.enable = true;
  };

  sound.enable = true;
  hardware.opengl.enable = true;

  users.users.noobuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" "adbusers" ];
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      home-manager
      ntfs3g
      cachix
      unzip
    ];
    # memoryAllocator.provider = "graphene-hardened";
  };

  i18n.defaultLocale = "ja_JP.UTF-8";

  fonts.fonts = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  virtualisation = {
    containers.storage.settings.storage.driver = "zfs";
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd.enable = true;
    waydroid.enable = true;
  };

  system = {
    stateVersion = "21.11";
    autoUpgrade = {
      enable = true;
      flake = "/home/noobuser/nixos-conf";
      flags = [ "--recreate-lock-file" "--commit-lock-file" ];
    };
  };
}
