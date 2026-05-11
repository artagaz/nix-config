{ self, pkgs, ... }: {
  flake.nixosModules.firefox = { pkgs, ... }: {
    home-manager.users.${self.user} = {
      programs.firefox = {
        enable = true;
        
        profiles.${self.user} = {
          isDefault = true;
          
          # Настройки (about:config)
          settings = {
            "browser.startup.homepage" = "https://google.com";
            "browser.search.region" = "RU";
            "intl.accept_languages" = "ru-ru,ru,en-us,en";
          };

          # Расширения
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            vimium
          ];
        };
      };
    };
  };
}
