{ config, pkgs, ...}:
{
  home.packages = with pkgs; let
    teams-vivaldi = makeDesktopItem {
      name = "Teams";
      desktopName = "Teams";
      genericName = "Microsoft Teams";
      exec = ''
        ${pkgs.vivaldi}/bin/vivaldi --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://teams.microsoft.com"'';
      icon = "teams";
      categories = ["Network" "InstantMessaging"];
      mimeTypes = ["x-scheme-handler/teams"];
  };
  in [teams-vivaldi];
}
