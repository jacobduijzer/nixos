{ pkgs, config, ...}:
{
  #services.swayidle = {
  #  enable = true;
  #  package = pkgs.swayidle;
  #  timeouts = [
  #    {
  #      timeout = 10;
  #      command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
  #    }
  #  ];
  #  events = [
  #    {
  #      event = "before-sleep";
  #      command = "${pkgs.swaylock}/bin/swaylock";
  #    }  
  #  ];
  #};
}
