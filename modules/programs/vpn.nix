{
  flake.nixosModules.vpn = { pkgs, ... }:
  {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
      extraSetFlags = [ "--operator=matthew" ];
    };
  };
}
