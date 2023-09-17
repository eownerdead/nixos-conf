{ config, ... }:
let
  sops = config.sops.secrets;

  sslConfig = {
    onlySSL = true;
    sslCertificate = sops.eownerdeadDedynIoCert.path;
    sslCertificateKey = sops.eownerdeadDedynIoCertKey.path;
  };
in {
  sops.secrets = {
    eownerdeadDedynIoCert.owner = config.services.nginx.user;
    eownerdeadDedynIoCertKey.owner = config.services.nginx.user;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedZstdSettings = true;
    recommendedBrotliSettings = true;
    virtualHosts = {
      "eownerdead.dedyn.io" = sslConfig // {
        locations."/".root = ./www.null.dedyn.io;
      };
      "www.eownerdead.dedyn.io" = sslConfig // {
        locations."/".root = ./www.null.dedyn.io;
      };
      "git.eownerdead.dedyn.io" = sslConfig;
    };
  };
}
