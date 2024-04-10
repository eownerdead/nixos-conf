{ lib, pkgs, inputs, ... }: {
  imports = [
    ../noobuser/cli.nix
    ../noobuser/git.nix
    ../noobuser/gpg.nix
    ../noobuser/pass.nix
    ../noobuser/firefox.nix
    ../noobuser/emacs

    ../noobuser/dev/nix.nix
  ];

  home = {
    username = "eownerdead";
    homeDirectory = "/home/eownerdead";
    stateVersion = "23.11";

    packages = with pkgs; [ dconf jetbrains-mono wayfire ];
  };

  programs = {
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      # https://github.com/NixOS/nixpkgs/issues/158449
      extensions = [{
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # uBlock Origin
      }];
    };
    home-manager.enable = true;
  };
}

