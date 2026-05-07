{ self, ... }:
{
  flake.nixosModules.base = { pkgs, ... }: {
    imports = [
      self.nixosModules.kitty
      self.nixosModules.git
    ];

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      gnome-clocks
      kdePackages.okular
      kdePackages.partitionmanager
      krita
      obsidian
      telegram-desktop
      vesktop
      mc
      btop
      htop
      firefox
      
    ];
    
    # List font packages installed in system profile.
    fonts.packages = with pkgs; [
      ibm-plex
      nerd-fonts.jetbrains-mono
    ];
  };

  flake = {
    user = "andrei";
  };
}
