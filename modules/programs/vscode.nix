{ self, pkgs, ... }:
{
  flake.nixosModules.vscode = { pkgs, ... }: {
    home-manager.users.${self.user} = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;

        profiles.default = {
          # расширения
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix           # Подсветка Nix
            jnoortheen.nix-ide     # LSP для Nix
            christian-kohler.path-intellisenseв
            oracle.sql-developer  # sql
            ms-python.python
          ];

          # настройки 
          userSettings = {
            "editor.fontSize" = 14;
            "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
            "workbench.colorTheme" = "Gruvbox Dark Hard";
            "editor.formatOnSave" = true;
            "window.titleBarStyle" = "custom";
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = { "command" = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ]; };
              };
            };
          };

          # бинды
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
