{ self, ... }:
{
  flake.nixosModules.firefox =
    { ... }:
    {
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
          };

          policies.ExtensionSettings = {
            "446900e4-71c2-419f-a6a7-df9c091e268b" = {
              # Bitwarden
              installation_mode = "force_installed";
              install_url = "https://mozilla.org";
            };
            "{d7740338-7013-41f2-959c-687f3b890947}" = {
              # Vimium
              installation_mode = "force_installed";
              install_url = "https://mozilla.org";
            };
          };

        };
      };
    };
}
