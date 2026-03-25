{ self, ... }:
{
  flake.nixosModules.gamedev = { pkgs, ... }: {
    imports = [
      self.nixosModules.neovim
      self.nixosModules.tmux
      self.nixosModules.git
    ];

    environment.systemPackages = with pkgs; [
      # aseprite
      (pkgs.bottles.override {removeWarningPopup = true; })
      dotnet-sdk
      godot-mono
      obs-studio
      winetricks
    ];
  };
}
