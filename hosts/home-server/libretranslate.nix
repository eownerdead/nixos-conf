{ pkgs, config, ... }:
# latest nixpkgs' one seems to broken.
{
  virtualisation.oci-containers.containers.libretranslate = {
    image = "libretranslate/libretranslate";
    ports = [ "5000:5000" ];
  };

  services.nginx.virtualHosts."libretranslate.eownerdead.dedyn.io".locations."/".proxyPass =
    "http://0.0.0.0:5000";
}
