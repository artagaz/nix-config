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

                # # --- Статичная читаемая палитра (Tokyo Night) ---
                # background_opacity = "0.8";
                # background = "#1a1b26";
                # foreground = "#a9b1d6";
                # selection_background = "#343b58";
                # selection_foreground = "#a9b1d6";
                # url_color = "#73daca";
                # cursor = "#c0caf5";

                # # Black
                # color0 = "#15161e";
                # color8 = "#414868";
                # # Red
                # color1 = "#f7768e";
                # color9 = "#f7768e";
                # # Green
                # color2 = "#9ece6a";
                # color10 = "#9ece6a";
                # # Yellow
                # color3 = "#e0af68";
                # color11 = "#e0af68";
                # # Blue
                # color4 = "#7aa2f7";
                # color12 = "#7aa2f7";
                # # Magenta
                # color5 = "#bb9af7";
                # color13 = "#bb9af7";
                # # Cyan
                # color6 = "#7dcfff";
                # color14 = "#7dcfff";
                # # White
                # color7 = "#a9b1d6";
                # color15 = "#c0caf5";
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
