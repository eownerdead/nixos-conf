# https://git.clan.lol/clan/clan-infra/src/branch/main/modules/web01/gitea/actions-runner.nix
{ inputs, config, pkgs, ... }:
let
  sops = config.sops.secrets;
  actions-root = pkgs.dockerTools.buildLayeredImage
    (pkgs.docker-nixpkgs.nix-flakes.buildArgs // {
      includeStorePaths = false;
    });
in {
  sops.secrets.codebergOrgRunnerToken = { };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.codebergOrg = {
      enable = true;
      url = "https://codeberg.org";
      labels = [ "nixos:docker://${actions-root.imageName}" ];
      name = config.networking.hostName;
      tokenFile = sops.codebergOrgRunnerToken.path;
      settings.containers = {
        options = "-v /nix/:/nix/";
        valid_volumes = [ "/nix/" ];
      };
    };
  };

  virtualisation.podman.enable = true;

  # https://blog.kotatsu.dev/posts/2023-04-21-woodpecker-nix-caching/
  virtualisation.podman.defaultNetwork.settings.dns_enable = true;
  networking.firewall.interfaces."podman+" = {
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 ];
  };

  systemd.services."gitea-runner-codebergOrg".serviceConfig.preStart = "${config.virtualisation.podman.package} load -i ${actions-root}";
}
