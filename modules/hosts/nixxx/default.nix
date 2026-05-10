# подключение конфиги с названием nixxx ------------------------------------------------------
{ inputs, self, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.nixxx ];
  };
}