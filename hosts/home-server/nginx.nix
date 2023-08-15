{ ... }:
let
  sslConfig = {
    onlySSL = true;
    sslCertificate = "/var/null.dedyn.io.pem";
    sslCertificateKey = "/var/null.dedyn.io.key";
  };
in
{
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
