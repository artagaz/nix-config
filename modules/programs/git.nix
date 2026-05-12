# настройки гита
{ self, ... }:
{
  flake.nixosModules.git = {
    home-manager.users.${self.user}.imports = [
      {
        programs.git = {
          enable = true;
          settings = {
            user = {
              name = "${self.user}";
              email = "${self.mail}";
            };
          };
        };
      }
    ];
  };
}
