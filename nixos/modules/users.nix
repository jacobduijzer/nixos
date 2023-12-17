{ config, pkgs, lib, inputs, user, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.users.jacob = {
		isNormalUser = true;
		description = "Jacob Duijzer";
		extraGroups = [ "networkmanager" "wheel" "docker" "video" "input" ];
		packages = with pkgs; [
      bitwarden 
      bitwarden-cli 
      bitwarden-menu
			spotify
			
      # browsers
      vivaldi
      microsoft-edge
			chromium
      google-chrome-dev

			# writing
      #emacs29
      emacs29-pgtk
			libreoffice-fresh
      tetex
      hugo
      texlive.combined.scheme-basic
      aspell
      aspellDicts.nl

      # communication
			ferdium
			slack
      zoom-us
      openfortivpn

			# development
			jetbrains.rider
			gnupg 
      pinentry
      nodejs_18
      yarn
      chromedriver
      plantuml-c4
      graphviz
      openjdk19
      kubectl
      docker-compose
      sass

			# image
			gimp
			grim
			slurp
			viewnior
			imagemagick
      swappy
      #rawtherapee
      #darktable
      krita
      digikam
      gImageReader

      # multimedia
      obs-studio
      vlc
      v4l-utils
      #wf-recorder

			# system
      bc
			alacritty	
			z-lua
			jq
      unzip
      dolphin
      zip
      libva-utils
      pciutils
      wdisplays
      virtualbox

      # zsh
      thefuck

      # misc
      calibre

      # i3 / xwindow
      arandr
      feh
      rofi
      scrot

      # sway
      #swayidle
      #swayosd
			#swaylock-effects 
      #physlock
      #wlogout 
      #swaybg  
			#waybar 
			#wayland-protocols
			#libsForQt5.qt5.qtwayland
			#kanshi                                    #laptop dncies
			#rofi mako rofimoji                        #Drawer + notifications
			#jellyfin-ffmpeg                           #multimedia libs
			#pavucontrol                               #Volume control
			#xfce.xfconf
			##cava                                      #Sound Visualized
			#wl-clipboard                              
			##wf-recorder                               #Video recorder
			#sway-contrib.grimshot                     #Screenshot
			##jffmpegthumbnailer                         #thumbnailer

      # audio
			playerctl                                 #play,pause..
			pamixer                                   #mixer
      pavucontrol
      #easyeffects

			brightnessctl                             #Brightness control

			# GTK Customization
			nordic
			papirus-icon-theme
			gtk3
			glib
			xcur2png
			rubyPackages.glib2
			libcanberra-gtk3                          #notification sound

			#########System#########
			libnotify
			poweralertd
			dbus
			curl
			blueman
		];
	};

	#programs = {
	#	sway = {
	#		enable = true;
	#	};
	#};

	#swaylock pass verify
	#security.pam.services.swaylock = {
	#	text = ''
	#		auth include login
	#	'';
	#};

	services.gvfs.enable = true; 
	services.tumbler.enable = true;

	programs.dconf.enable = lib.mkDefault true;

	#DIRS
	environment.etc."xdg/user-dirs.defaults".text= ''
		DESKTOP=$HOME/Desktop
		DOWNLOAD=$HOME/Downloads
		TEMPLATES=$HOME/Templates
		PUBLICSHARE=$HOME/Public
		DOCUMENTS=$HOME/Documents
		MUSIC=$HOME/Music
		PICTURES=$HOME/Photos
		VIDEOS=$HOME/Video 
	'';
}
