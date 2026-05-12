{ self, ... }:
{
  flake.nixosModules.niri =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        # управляет цветами под обои
        self.nixosModules.matugen
        # панельки и тд
        self.nixosModules.noctalia
      ];

      programs.niri.enable = true;

      # логин-менеджер
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      # автомонтирование флешек
      services.udisks2.enable = true;
      # корзина и тд для проводника
      services.gvfs.enable = true;

      # пакеты для нири
      environment.systemPackages = with pkgs; [
        brightnessctl
        eog
        gnome-themes-extra
        kdePackages.breeze
        kdePackages.breeze-icons
        kdePackages.dolphin
        kdePackages.kcalc
        mpv
        nautilus
        pywal
        wl-clipboard
        xwayland-satellite
      ];

      home-manager.users.${self.user} =
        { ... }:
        {

          # лаунчер приложений
          programs.rofi = {
            enable = true;
            font = "${self.font.mono} 18";
            extraConfig = {
              kb-row-up = "Up";
              kb-row-down = "Down";
              kb-accept-entry = "Control+m,Return,KP_Enter";
              kb-remove-to-eol = "Control+Shift+e";
              kb-mode-next = "Shift+Right,Control+Tab,Control+l";
              kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
              kb-mode-complete = "";
              kb-remove-char-back = "BackSpace";
            };
            theme = "~/.cache/wal/colors-rofi-dark.rasi";
          };

          # всплывающее окно аутентификации
          services.polkit-gnome.enable = true;
          systemd.user.services.polkit-gnome = {
            Service = {
              Restart = "on-failure";
              RestartSec = 1;
            };
            Unit = {
              StartLimitIntervalSec = 30;
              StartLimitBurst = 10;
            };
          };

          # привязка конфига нири
          xdg.configFile."niri/config.kdl".source = ./config.kdl;

          # приложения по умолчанию
          xdg.mimeApps = {
            enable = true;
            defaultApplications =
              let
                imageViewer = "org.gnome.eog.desktop";
                documentViewer = "org.kde.okular.desktop";
                videoViewer = "mpv.desktop";
              in
              {
                "image/png" = imageViewer;
                "image/jpg" = imageViewer;
                "image/jpeg" = imageViewer;
                "document/pdf" = documentViewer;
                "video/mp4" = videoViewer;
                "video/webm" = videoViewer;
              };
          };

          # Set cursor theme.
          home.file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";

          # Set dark theme for GTK programs.
          dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

          # Set GTK theme.
          gtk = {
            enable = true;
            gtk4.theme = null;
            theme = {
              name = "adw-gtk3-dark";
              package = pkgs.adw-gtk3;
            };
            cursorTheme = {
              name = "Bibata-Modern-Classic";
              package = pkgs.bibata-cursors;
              size = 20;
            };
            font = {
              name = "${self.font.mono}";
              size = 13;
            };
          };

          # Make QT follow GTK theme.
          qt = {
            enable = true;
            platformTheme.name = "gtk3";

            qt5ctSettings = {
              Fonts = {
                fixed = "\"${self.font.mono},13\"";
                general = "\"${self.font.mono},13\"";
              };
            };

            qt6ctSettings = {
              Fonts = {
                fixed = "\"${self.font.mono},13\"";
                general = "\"${self.font.mono},13\"";
              };
            };
          };
        };
    };
}
