{ self, pkgs, ... }:
{
  flake.nixosModules.vscode = { pkgs, ... }: {
    home-manager.users.${self.user} = {
      programs.vscode = {
        enable = true;
        # Можно выбрать обычный vscode или vscodium (без телеметрии)
        package = pkgs.vscode;

        profiles.default = {
          # Твои расширения (ищи названия на search.nixos.org)
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix           # Подсветка Nix
            jnoortheen.nix-ide     # LSP для Nix
            ms-ceintl.vscode-language-pack-ru # Русский язык
            christian-kohler.path-intellisense
          ];

          # Твои настройки (settings.json) прямо здесь
          userSettings = {
            "editor.fontSize" = 14;
            "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
            "workbench.colorTheme" = "Gruvbox Dark Hard"; # Или какая тебе нравится
            "editor.formatOnSave" = true;
            "window.titleBarStyle" = "custom"; # Важно для Niri/Wayland
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd"; # Или nil
          };

          # Твои горячие клавиши (keybindings.json)
          keybindings = [
            {
              key = "ctrl+s";
              command = "workbench.action.files.save";
            }
          ];
        };
      };
    };
  };
}
