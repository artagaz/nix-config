# сам конфиг ---------------------------------------------------------------------------------
{ self, ... }:
{
  flake.nixosModules.nixxx =
    { pkgs, ... }:
    {
      # пользовательский аккаунт
      users.users.${self.user} = {
        # группы пользователя
        extraGroups = [ "wheel" ];
        isNormalUser = true;

        # личные пакеты пользователя
        packages = with pkgs; [
          tree
        ];
      };

      # разрешить несвободное ПО
      nixpkgs.config.allowUnfree = true;

      # hostname
      networking.hostName = "${self.hostname}";

      # timezone
      time.timeZone = "Asia/Krasnoyarsk";

      # языки
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

      # загрузчик
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "/dev/sda";
      boot.loader.grub.useOSProber = true;

      # системные хуйнюшки ---------------------------------------------------------------------------------
      # Enable flakes.
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Enable store optimization on every rebuild.
      nix.settings.auto-optimise-store = true;

      # Enable automatic garbace collection.
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = true;

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable bluetooth.
      hardware.bluetooth.enable = true;

      # Enable sound.
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };

      # для ноутбуков
      # Enable TLP.
      /*
        services.tlp = {
          enable = true;
          settings = {
            # Improve performance on battery.
            CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
            PLATFORM_PROFILE_ON_BAT = "performance";
          };
        };
      */

      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
