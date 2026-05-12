{ self, ... }:
{
  flake.nixosModules.kitty =
    { ... }:
    {
      config = {
        home-manager.users.${self.user}.imports = [
          {
            programs.kitty = {
              enable = true;
              font = {
                name = "${self.font.mono}";
                size = 13;
              };

              settings = {
                confirm_os_window_close = 0;
                remember_window_size = "no";
              };

              extraConfig = ''
                include ~/.cache/wal/colors-kitty.conf
                background_opacity 0.8
              '';
            };
          }
        ];
      };
    };
}
