{ config, pkgs, ... }:

{ 
  imports = [ 
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true; boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname. Pick only one of the below 
  # networking options. networking.wireless.enable = true; # Enables wireless support via 
  # wpa_supplicant. networking.networkmanager.enable = true; # Easiest to use and most 
  # distros use this by default.

  time.timeZone = "Europe/Amsterdam";

  # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    fira
    cooper-hewitt
    ibm-plex
    jetbrains-mono
    iosevka
    # bitmap
    spleen
    fira-code-symbols
    powerline-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];


  # Enable the X11 windowing system. 

  hardware.opengl.enable = true;
  #services.xserver.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting" ];
    
    #desktopManager.default = "none";
    #desktopManager.xterm.enable = false;
    displayManager = {
      lightdm.enable = false;
    };
    displayManager.defaultSession = "sway";
    #windowManager.default = "none+sway";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako # notification daemon
      grim
     #kanshi
      slurp
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.waybar.enable = true;
  

  # Configure keymap in X11 services.xserver.layout = "us"; services.xserver.xkbOptions = { 
  #   "eurosign:e"; "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents. services.printing.enable = true;

  # Enable sound. sound.enable = true; hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager). 
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jacob = {
    isNormalUser = true; 
    extraGroups = [ "wheel" ];   #   = with pkgs; [ firefox thunderbird ];
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [ 
    # system

    # development
    dotnet-sdk_7
    dotnet-runtime_7
    dotnet-aspnetcore_7 
    jetbrains.rider
    git

    # misc
    calibre
    ferdium
    firefox
    slack
    spotify
    vim 

    # work - it & care
    openfortivpn
  ];

  # Some programs need SUID wrappers, can be configured further or are started in user 
  # sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.openssh.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  #nixpkgs.config.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.x11 = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; 
  # networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. 
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system 
  # (/run/current-system/configuration.nix). This is useful in case you accidentally delete 
  # configuration.nix. system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default settings for stateful 
  # data, like file locations and database versions on your system were taken. It‘s 
  # perfectly fine and recommended to leave this value at the release version of the first 
  # install of this system. Before changing this value read the documentation for this 
  # option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

