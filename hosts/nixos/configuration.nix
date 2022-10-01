{ config, pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/enable-flake.nix
    ../common/auto-gc.nix
    ../common/use-local-nix.nix
    ../common/auto-upgrade.nix
    ../common/doas.nix
  ];

  nix = {
    settings.auto-optimise-store = true;
    binaryCaches = [
      "https://cuda-maintainers.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
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
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
      extraLayouts.fast = {
        description = "";
        languages = [ "eng" "jpn" ];
        symbolsFile = ./fastmap;
      };
    };
    gnome = {
      chrome-gnome-shell.enable = true;
      core-developer-tools.enable = true;
    };
    printing.enable = true;
    avahi.nssmdns = true;
    flatpak.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "jp106";
  # services.xserver.xkbOptions = "eurosign:e";

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true; # Fix suspend on wayland
    };
  };

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
      cachix
      unzip
    ];
    # memoryAllocator.provider = "graphene-hardened";
    variables = {
      # https://github.com/NixOS/nixpkgs/issues/32580
      WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    };
  };

  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = [ pkgs.my.ibus-mozc-ut ];
    };
  };

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

  system.stateVersion = "21.11";
}
