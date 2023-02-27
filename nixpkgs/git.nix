{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jacob Duijzer";
    userEmail = "jacob@duijzer.com";
  };
}
