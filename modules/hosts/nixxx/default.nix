# подключение конфиги с названием nixxx ------------------------------------------------------
{ inputs, self, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixxx # sys config
      self.nixosModules.nixxxHardware # hardware
      self.nixosModules.connect_programs # programs
    ];
  };
}
