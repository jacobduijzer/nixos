{ config, pkgs, lib, ... }:
{
  #imports = [
  #  ./dunst.nix
  #];

  services.xserver = {
    enable = true;

    xkbOptions = "caps:escape";

    desktopManager = { 
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3lock-fancy-rapid
        i3blocks
        polybarFull
      ];

      extraSessionCommands = ''
        ${pkgs.dunst}/bin/dunst &
        keyctl link @u @s
      '';
    };

    displayManager.lightdm = {
      enable = true;
      greeters = { 
        slick = { 
          enable = true;
        };
      };
    };
    displayManager.defaultSession = "none+i3";

    xrandrHeads = [
      "HDMI-1"
      {
        output = "HDMI-1";
        primary = false;
        monitorConfig = ''
          DisplaySize 700 395
        '';
      }
      "e-DP1"
      {
        output = "e-DP1";
        primary = true;
        monitorConfig = ''
          DisplaySize 331 226
        '';
      }
    ];
  };
}
