{ inputs, self, ... }:
let
  wallpaper = "/home/${self.user}/Pictures/romashki.jpg";
  ff_image = "/home/${self.user}/Pictures/logo.jpg";

  font = {
    mono = "JetBrainsMonoNerdFontMono";
    propo = "JetBrainsMonoNerdFontPropo";
  };

  border = {
    main = "12";
    small = "8";
  };
in
{
  # тут переменные
  flake = {
    inherit font;
    inherit wallpaper;
    inherit border;
    inherit ff_image;

    user = "andrei";
    mail = "vaylinnnn6@gmail.com";
    hostname = "nixos";
  };

  imports = [ inputs.flake-parts.flakeModules.modules ];
  systems = [ "x86_64-linux" ];

  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      backupCommand = "rm";

      # пользователь хоме манагера
      users.${self.user} = {
        home.stateVersion = "26.05";
        programs.home-manager.enable = true;
      };
    };
  };
}
