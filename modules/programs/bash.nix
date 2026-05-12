# тут алиасы для шелла всякие
{ self, ... }:
{
  flake.nixosModules.bash = {
    home-manager.users.${self.user}.imports = [
      {
        programs.bash = {
          enable = true;
          bashrcExtra = ''
            PS1='\n\[\033[1;36m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
          '';
          shellAliases = {
            nrb = "sudo nixos-rebuild boot --flake .#nixos";
            nrs = "sudo nixos-rebuild switch --flake .#nixos";
            nrt = "sudo nixos-rebuild test --flake .#nixos";
            pls = "sudo";
            nsw = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
            nca = "sudo nix-collect-garbage -d && sudo nix-collect-garbage";
          };
        };
      }
    ];
  };
}
