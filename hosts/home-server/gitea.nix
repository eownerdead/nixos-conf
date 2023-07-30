{ config, pkgs, ... }:
{
  # users.users."${config.services.nginx.user}".extraGroups = [ config.services.gitea.group ];

  services = {
    nginx = {
      enable = true;
      virtualHosts."git.null.dedyn.io".locations."/".extraConfig = ''
        include ${config.services.nginx.package}/conf/fastcgi.conf;
        fastcgi_pass unix:${config.services.gitea.settings.server.HTTP_ADDR};
      '';
    };

    gitea = {
      enable = true;
      package = pkgs.forgejo;
      database.type = "mysql";
      settings = {
        service.DISABLE_REGISTRATION = true;
        server.PROTOCOL = "fcgi+unix";
      };
    };
  };
}
