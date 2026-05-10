{ self, ... }:
{
  flake.nixosModules.base = { pkgs, ... }: {
    imports = [
      # простые конфиги для программ тут
      self.nixosModules.kitty
      self.nixosModules.git
      self.nixosModules.bash
      self.nixosModules.vscode
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
      firefox      
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
