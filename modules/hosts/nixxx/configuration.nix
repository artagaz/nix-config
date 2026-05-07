/* ┌──────────────────────────────────────────┐
   │             системный конфиг             │
   └──────────────────────────────────────────┘ */
{ self, ... }:
{
  flake.nixosModules.nixxx = { pkgs, ... }: {

/* ┌──────────────────────────────────────────┐
   │      импорт модулей  с програмками       │
   └──────────────────────────────────────────┘ */
    imports = [
      self.nixosModules.nixxxHardware

      # тут программки
      self.nixosModules.base
      
      # тут описанные через flakes
      self.nixosModules.fastfetch
      self.nixosModules.home-manager
      self.nixosModules.vscode 

      # тут графические окружения
      self.nixosModules.niri
      self.nixosModules.xfcerdp
    ];


/* ┌──────────────────────────────────────────┐                                                                                                                                                                                 
   │                 GRUB                     │                                                                                                                                                                                 
   └──────────────────────────────────────────┘ */
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;


    # Enable flakes.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable store optimization on every rebuild.
    nix.settings.auto-optimise-store = true;

    # Enable automatic garbace collection.
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    networking.hostName = "nixos"; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Krasnoyarsk";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable bluetooth.
    hardware.bluetooth.enable = true;

    # Enable sound.
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

# Локализация
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };



    # Enable TLP.
    services.tlp = {
      enable = true;
      settings = {
        # Improve performance on battery.
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
        PLATFORM_PROFILE_ON_BAT = "performance";
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${self.user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };
  
    # Allow unfree packages.
    nixpkgs.config.allowUnfree = true;


    system.stateVersion = "25.11"; # Did you read the comment?
  };
}

