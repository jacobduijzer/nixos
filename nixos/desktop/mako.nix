{ config, pkgs, lib, ... }:
{
  programs.mako = {
    enable = true;
    defaultTimeout = 5000;
    anchor = "top-center";

    # style
    font = "JetBrainsMono Nerd Font 14";
    backgroundColor = "#ffffff";
    textColor = "#000000";
    borderColor = "#FF8E0D";
    width = 600;
    height = 200;
    borderRadius = 0;
  };
}
