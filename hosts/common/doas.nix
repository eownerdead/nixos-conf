{ pkgs, ... }:
{
  # Use `doas` instead of `sudo`
  security = {
    sudo.enable = false;
    doas.enable = true;
  };

  environment.systemPackages = [ pkgs.doas-sudo-shim ];
}
