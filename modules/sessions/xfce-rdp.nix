{ self, ... }:
{
  flake.nixosModules.xfcerdp = { pkgs, lib, ... }: {
    services.xserver = {
      enable = true;
      displayManager.sddm.enable = lib.mkDefault true; # Оставляем SDDM как вход
      desktopManager.xfce.enable = true;
    };

    # Доп пакеты для Xfce, чтобы он не был совсем голым
    environment.systemPackages = with pkgs; [
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-whiskermenu-plugin # Удобное меню "Пуск"
      networkmanagerapplet         # Иконка сети в трее
    ];

      services.xrdp = {
      enable = true;
      defaultWindowManager = "xfce4-session";
      openFirewall = true;
    };

  };
}
