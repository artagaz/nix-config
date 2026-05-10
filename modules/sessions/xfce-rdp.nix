/* ┌──────────────────────────────────────────┐                                                                                                                                                                                 
   │             XFCE для RDP                 │                                                                                                                                                                                 
   └──────────────────────────────────────────┘ */
{ self, ... }:
{
  flake.nixosModules.xfcerdp = { pkgs, lib, ... }: {
    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
    };
  services.displayManager.sddm.enable = lib.mkDefault true;

/* ┌──────────────────────────────────────────┐                                                                                                                                                                                 
   │              доп пакеты                  │                                                                                                                                                                                 
   └──────────────────────────────────────────┘ */
    environment.systemPackages = with pkgs; [
      xfce4-pulseaudio-plugin
      xfce4-whiskermenu-plugin # Удобное меню "Пуск"
      networkmanagerapplet         # Иконка сети в трее
    ];

/* ┌──────────────────────────────────────────┐                                                                                                                                                                                 
   │                 RDP настройки            │                                                                                                                                                                                 
   └──────────────────────────────────────────┘ */
      services.xrdp = {
      enable = true;
      defaultWindowManager = "xfce4-session";
      openFirewall = true;
    };
  };
}
