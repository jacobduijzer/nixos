{
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/JacobsNas" = {
    device = "//192.168.178.103/homes";
    fsType = "cifs";
    options = 
    let
      automount_opts = "x-systemd.automount,noauto,x-systemd.itle-tileout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in
      ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
}
