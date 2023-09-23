{ config, pkgs, lib, inputs, user, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.users.jacob = {
		isNormalUser = true;
		description = "Jacob Duijzer";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [
			vivaldi
			chromium
			ferdium
			bitwarden bitwarden-cli bitwarden-menu
			spotify
			slack
			emacs
			
			wlr-randr
			
			# misc
			libreoffice-fresh

			# development
			jetbrains.rider
			gnupg pinentry
			dotnet-sdk_7
			dotnet-aspnetcore_7
			dotnet-runtime_7

			# image
			gimp
			grim
			slurp
			viewnior                                  #image viewr
			imagemagick

			# system
			z-lua
			jq

			############
			swaylock-effects swayidle wlogout swaybg  #Login etc..  
			waybar                                    #topbar 
			wayland-protocols
			libsForQt5.qt5.qtwayland
			kanshi                                    #laptop dncies
			rofi mako rofimoji                        #Drawer + notifications
			jellyfin-ffmpeg                           #multimedia libs
			pavucontrol                               #Volume control
			xfce.thunar                               #filemanager
			xfce.xfconf
			#cava                                      #Sound Visualized
			wl-clipboard                              
			#wf-recorder                               #Video recorder
			sway-contrib.grimshot                     #Screenshot
			#jffmpegthumbnailer                         #thumbnailer
			playerctl                                 #play,pause..
			pamixer                                   #mixer
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

	#thunar dencies
	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
	];
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


   #Overlays
    #Waybar wlr/Workspaces
    #nixpkgs.overlays = [
    #(self: super: {
    #  waybar = super.waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  });
    #})
    #];


}
