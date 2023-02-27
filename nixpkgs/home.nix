{ config, pkgs, ... }:

{ 
  home.username = "jacob";
  home.homeDirectory = "/home/jacob";

  imports = [
    ./git.nix
  ];

  home.packages = [
    pkgs.htop
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
