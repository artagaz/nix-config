{ self, ... }:
{
  flake.nixosModules.kitty = { config, lib, ... }: {
    options = {
      kitty.pywal = {
        enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
        };
      };
    };

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
            background_opacity = lib.mkIf config.kitty.pywal.enable 0.85;
            remember_window_size = "no";
          };
          extraConfig = lib.mkIf config.kitty.pywal.enable ''
            include ~/.cache/wal/colors-kitty.conf
          '';
          themeFile = "gruvbox-dark";
        };
      }
      ];
    };
  };
}
