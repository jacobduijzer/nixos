{ config, pkgs, lib, ... }:
{
  programs.mako = {
    enable = true;
    defaultTimeout = 5000;

    # style
    backgroundColor = "#ffffff";
    textColor = "#000000";
    borderColor = "#FF8E0D";
    width = 500;
    height = 200;
    borderRadius = 10;
  };
}
