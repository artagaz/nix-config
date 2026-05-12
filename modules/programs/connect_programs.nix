{ self, ... }:
{
  flake.nixosModules.connect_programs =
    { pkgs, ... }:
    {
      imports = [
        # конфиги для программ тут
        self.nixosModules.kitty
        self.nixosModules.git
        self.nixosModules.bash
        self.nixosModules.vscode
        self.nixosModules.firefox
        self.nixosModules.fastfetch
        self.nixosModules.starship

        self.nixosModules.home-manager # хуй знает где этот модуль

        # тут графические окружения
        self.nixosModules.niri
        self.nixosModules.xfcerdp
      ];

      # программы для всей системы
      environment.systemPackages = with pkgs; [
        gnome-clocks
        kdePackages.okular
        kdePackages.partitionmanager
        telegram-desktop
        vesktop
        mc
        btop
        htop
        yandex-music
        vmware-workstation
        (callPackage ../../pkgs/assistant.nix { }) # ассистент
      ];

      # шрифты
      fonts.packages = with pkgs; [
        ibm-plex
        nerd-fonts.jetbrains-mono
      ];
    };
}
