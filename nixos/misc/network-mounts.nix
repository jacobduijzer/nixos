{ pkgs, ... }:
{
  fileSystems."/mnt/JacobsNas" = {
    device = "//192.168.178.103/homes";
    fsType = "cifs";
    options = 
    let
      automount_opts = "x-systemd.automount,noauto,x-systemd.itle-tileout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in
      ["${automount_opts},nobrl,credentials=/etc/nixos/smb-secrets,uid=jacob,gid=100,rw"];
  };

  fileSystems."/mnt/KellysNas" = {
    device = "//192.168.178.2/homes";
    fsType = "cifs";
    options = 
    let
      automount_opts = "x-systemd.automount,noauto,x-systemd.itle-tileout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in
      ["${automount_opts},nobrl,credentials=/etc/nixos/smb-secrets,uid=jacob,gid=100,rw"];
  };
}
