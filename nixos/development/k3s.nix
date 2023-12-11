{
  networking.firewall.allowedTCPPorts = [ 6443 ];
  services.k3s.enable = false;
  services.k3s.role ="server";
  services.k3s.extraFlags = toString [
  ];
}
