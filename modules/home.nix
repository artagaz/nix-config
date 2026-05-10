{ inputs, self, ... }:{
  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      backupCommand = "rm";

      # пользователь хоме манагера
      users.${self.user} = {
        home.stateVersion = "26.05";
        programs.home-manager.enable = true;
      };
    };
  };
}
