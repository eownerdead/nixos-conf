# https://nixos.wiki/wiki/Encrypted_DNS
{ ... }:
{
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      http3 = true;
    };
  };
}
