############################################################################
#                                                                          #
#    ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗    ██████╗ ██████╗             #
#    ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝   ██╔════╝ ██╔══██╗            #
#    ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗   ██║  ███╗██████╔╝            #
#    ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║   ██║   ██║██╔═══╝             #
#    ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║   ╚██████╔╝██║                 #
#    ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚═╝                 #
#                                                                          #
#    User: andrei | Host: nixos | Env: niri / xfce                         #
############################################################################


{
  inputs = {
  
  /* ┌──────────────────────────────────────────┐
     │          системные импорты               │
     └──────────────────────────────────────────┘ */
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  /* ┌──────────────────────────────────────────┐                                                                                                                                                                               
     │           импорт модулей                 │                                                                                                                                                                               
     └──────────────────────────────────────────┘ */
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
