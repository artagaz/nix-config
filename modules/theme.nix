{ self, ... }:
let
  wallpaper = "/home/${self.user}/Pictures/romashki.jpg";

  font = {
    mono = "JetBrainsMonoNerdFontMono";
    propo = "JetBrainsMonoNerdFontPropo";
  };

  border = {
    main = "12";
    small = "8";
  };
in {
  flake = {
    inherit font;
    inherit wallpaper;
    inherit border;
  };
}
