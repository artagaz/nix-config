{ self, ... }:
{flake.nixosModules.base = { pkgs, ... }: {
    imports = [
      # простые конфиги для программ тут
      self.nixosModules.kitty
      self.nixosModules.git
      self.nixosModules.bash
      self.nixosModules.vscode
      self.nixosModules.firefox
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
    ];
    
    # шрифты
    fonts.packages = with pkgs; [
      ibm-plex
      nerd-fonts.jetbrains-mono
    ];
  };

  flake = {
    user = "andrei";
  };
}
