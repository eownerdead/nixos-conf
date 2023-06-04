{ config, pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko-config.nix {
      disk = "/dev/disk/by-id/ata-WDC_WD5000AAKX-60U6AA0_WD-WCC2E5PS4JDV";
    })

    ../common/enable-flake.nix
    ../common/auto-gc.nix
    ../common/doas.nix
  ];

  nix.settings.auto-optimise-store = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = with config.boot.kernelPackages; [ rtl8821au ];
  };

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "home-tv";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 8080 ];
      allowedUDPPorts = [ 8080 ];
    };
  };

  i18n.defaultLocale = "ja_JP.UTF-8";

  sound.enable = true;
  hardware.opengl.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [ noto-fonts-cjk-sans noto-fonts-cjk-serif ];
  };

  users.users.noobuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.git.enable = true;

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
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  };

  system.stateVersion = "22.11";
}
