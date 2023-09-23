{ config, pkgs, lib, input, modulesPath, ... }:

{
	imports = [
		./hardware-configuration.nix
 		
		# config
		./modules/users.nix
		./modules/greetd.nix

		# audio
		./audio/general.nix
		./audio/bluetooth.nix

		# desktop
		./desktop/sway.nix

		# development
		./development/k3s.nix
      
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

	# Set your time zone.
	time.timeZone = "Europe/Amsterdam";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Enable the X11 windowing system.
	# services.xserver.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	environment.systemPackages = with pkgs; [
		vim 
		wget
		git
		k3d
		killall
		sqlite
		cmake
		gcc
		zsh
	];

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	services.pcscd.enable = true;
	programs.gnupg.agent = {
	   enable = true;
	   pinentryFlavor = "curses";
	   enableSSHSupport = true;
	};

	# docker
	virtualisation.docker.enable = true;

	# Wayland related
	#security.polkit.enable = true;
	#hardware.opengl.enable = true;
	security.pam.services.swaylock = {
		text = "auth include login";
	};

	# fonts
	fonts.packages = with pkgs; [
		noto-fonts
		fira-code
		jetbrains-mono
		font-awesome
	];

	networking.firewall.allowedTCPPorts = [ 22 80 443 ];
	networking.firewall.enable = false;

	# shells
	environment.shells = with pkgs; [ zsh ];
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	# Automatic garbage collection
	nix.gc = {
		automatic = true;
		dates = "Weekly";
		options = "--delete-older-than 7d";
	};

	system.stateVersion = "23.05"; # Did you read the comment?
}

