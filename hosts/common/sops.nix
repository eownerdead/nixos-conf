{ config, ... }:
{
  sops = {
    age.sshKeyPaths = [ ];
    gnupg = {
      home = config.home-manager.users.noobuser.programs.gpg.homedir;
      sshKeyPaths = [ ];
    };
    secrets.noobuserPassword = {
      sopsFile = ../../users/noobuser/sops.yaml;
      key = "password";
      neededForUsers = true;
    };
  };
}

