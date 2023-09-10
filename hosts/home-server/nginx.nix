{ config, ... }:
let
  sops = config.sops.secrets;

  sslConfig = {
    onlySSL = true;
    sslCertificate = sops.nullDedynIoCert.path;
    sslCertificateKey = sops.nullDedynIoCertKey.path;
  };
in {
  sops.secrets = {
    nullDedynIoCert.owner = config.services.nginx.user;
    nullDedynIoCertKey.owner = config.services.nginx.user;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedZstdSettings = true;
    recommendedBrotliSettings = true;
    virtualHosts = {
      "null.dedyn.io" = sslConfig // {
        locations."/".root = ./www.null.dedyn.io;
      };
      "www.null.dedyn.io" = sslConfig // {
        locations."/".root = ./www.null.dedyn.io;
      };
      "git.null.dedyn.io" = sslConfig;
    };
  };
}
