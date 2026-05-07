{ self, ... }:
{
  flake.nixosModules.laptopHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    # --- ДОБАВЬ ЭТО ---
    # Драйверы для VMware
    services.xserver.videoDrivers = [ "vmware" ];
    virtualisation.vmware.guest.enable = true;

    # Ускорение рендеринга
    hardware.graphics.enable = true;
    # ------------------

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/d0270880-39ef-4ae8-8701-87606a0d4578";
      fsType = "ext4";
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/b5ad4e1d-8495-4ebc-be6b-b8be539d0ac1"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
