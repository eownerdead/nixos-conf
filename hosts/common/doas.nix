{ pkgs, ... }:
{
  # Use `doas` instead of `sudo`
  security = {
    sudo.enable = false;
    doas.enable = true;
  };

  programs.bash.shellAliases.sudo = "doas";
}
