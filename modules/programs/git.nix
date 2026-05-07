{ self, ... }:
{
  flake.nixosModules.git = {
    home-manager.users.${self.user}.imports = [
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "andre";
            email = "vaylinnnn6@gmail.com";
          };
          core = {
            editor = "nvim";
          };
        };
      };
    }
    ];
  };
}
