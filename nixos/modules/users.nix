{ config, pkgs, lib, inputs, user, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.users.jacob = {
		isNormalUser = true;
		description = "Jacob Duijzer";
		extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
		packages = with pkgs; [
			vivaldi
			chromium
			bitwarden 
      bitwarden-cli 
      bitwarden-menu
			spotify
			emacs
			
			wlr-randr
			
			# misc
			libreoffice-fresh
      tetex
      microsoft-edge
      hugo
      texlive.combined.scheme-full

      # communication
			ferdium
			slack
      zoom-us

			# development
			jetbrains.rider
			gnupg pinentry
      nodejs_18
      yarn
      chromedriver

			# image
			gimp
			grim
			slurp
			viewnior                                  #image viewr
			imagemagick
      swappy
      rawtherapee
      darktable
      krita

			# system
			z-lua
			jq
      unzip
      ydotool
      dolphin

      # zsh
      thefuck

      # misc
      calibre

      # sway
      swayidle
      swayosd

			############
			swaylock-effects wlogout swaybg  #Login etc..  
			waybar                                    #topbar 
			wayland-protocols
			libsForQt5.qt5.qtwayland
			kanshi                                    #laptop dncies
			rofi mako rofimoji                        #Drawer + notifications
			jellyfin-ffmpeg                           #multimedia libs
			pavucontrol                               #Volume control
			xfce.xfconf
			#cava                                      #Sound Visualized
			wl-clipboard                              
			#wf-recorder                               #Video recorder
			sway-contrib.grimshot                     #Screenshot
			#jffmpegthumbnailer                         #thumbnailer

      # audio
			playerctl                                 #play,pause..
			pamixer                                   #mixer
      easyeffects

			brightnessctl                             #Brightness control
			####GTK Customization####
			nordic
			papirus-icon-theme
			gtk3
			glib
			xcur2png
			rubyPackages.glib2
			libcanberra-gtk3                          #notification sound
			#########System#########
			alacritty	
			#gnome.gnome-system-monitor
			libnotify
			poweralertd
			dbus
			#gsettings-desktop-schemas
			#wrapGAppsHook
			#xdg-desktop-portal-hyprland
			####photoshop dencies####
			#gnome.zenity
			#wine64Packages.waylandFull
			curl
			blueman
		];
	};

	programs = {
		sway = {
			enable = true;
		};
	};

	#swaylock pass verify
	security.pam.services.swaylock = {
		text = ''
			auth include login
		'';
	};

	services.gvfs.enable = true; 
	services.tumbler.enable = true;

	#gnome outside gnome
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
