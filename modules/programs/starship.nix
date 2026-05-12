{ self, lib, ... }:
{
  flake.nixosModules.starship = {
    home-manager.users.${self.user}.imports = [
      {
        programs = {
          starship = {
            enable = true;
            enableBashIntegration = true;
            settings = lib.mkDefault {
              format = lib.concatStrings [
                "$username"
                "$hostname"
                "$directory"
                "$git_branch"
                "$git_state"
                "$git_status"
                "$cmd_duration"
                "$line_break"
                "$shlvl"
                "$nix_shell"
                "$python"
                "$character"
              ];

              shlvl = {
                disabled = false;
                threshold = 3;
                symbol = "ﰬ";
                style = "bright-red bold";
              };

              username = {
                disabled = false;
                show_always = true;
                style_user = "bright-white bold";
                style_root = "bright-red bold";
                format = "[$user]($style)";
              };

              hostname = {
                ssh_only = false;
                style = "bright-green bold"; # Можно выбрать любой цвет
                format = "[@$hostname]($style) "; # Пробел в конце, чтобы не слипалось с директорией

              };

              directory = {
                style = "blue";
                truncation_length = 0;
                truncate_to_repo = false;
                format = "[$path]($style)[$read_only]($read_only_style) "; # Убираем "at" или "in" перед путем
              };

              character = {
                success_symbol = "[❯](purple)";
                error_symbol = "[❯](red)";
                vimcmd_symbol = "[❮](green)";
              };

              git_branch = {
                # Скобки стоят снаружи стилевой разметки, так они точно отобразятся
                format = "($symbol$branch )";
                style = "bright-black";
                symbol = "branch:"; # Выносим текст "branch:" в символ, чтобы было чище
              };

              git_status = {
                # Убедитесь, что формат включает нужные переменные
                format = "([$all_status$ahead_behind]($style) )";
                style = "bold red";

                # Вместо пробелов ставим понятные символы
                conflicted = "="; # Конфликты
                ahead = "⇡"; # Ветка впереди удаленной
                behind = "⇣"; # Ветка отстает
                diverged = "⇕"; # Расхождение веток
                untracked = "?"; # Новые файлы (не в индексе)
                modified = "!"; # Измененные файлы
                staged = "+"; # Файлы в индексе (готовы к коммиту)
                renamed = "»"; # Переименованные
                deleted = "✘"; # Удаленные
                stashed = "≡"; # Спрятанные изменения (stash)
              };

              git_state = {
                format = "([$state( $progress_current/$progress_total)]($style)) ";
                style = "bold yellow";
              };

              cmd_duration = {
                format = "took [   $duration]($style) ";
                style = "yellow";
              };

              python = {
                # Добавляем символ змеи и версию Python
                symbol = "🐍 ";
                #format = "via [$symbol$virtualenv]($style) ";
                style = "bold yellow"; # Желтый — классический цвет Python

                # Если хотите видеть и версию интерпретатора (например, 3.11)
                format = "via [$symbol$virtualenv]($style) [($version)]($style) ";
              };

              nix_shell = {
                symbol = "❄️ ";
                format = "via [$symbol$name]($style) ";
                style = "bold blue";
              };

            };
          };
        };
      }
    ];

  };
}
