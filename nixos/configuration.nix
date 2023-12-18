{ config, pkgs, lib, input, modulesPath, ... }:
{
	imports = [
		./hardware-configuration.nix
 		
		# config
		./home/users.nix
		./misc/vim.nix
    ./misc/network-mounts.nix

		# audio
		./audio/general.nix
		./audio/bluetooth.nix

		# desktop
		#./desktop/sway.nix
    ./desktop/i3.nix

		# development
		./development/k3s.nix
	];

	nixpkgs = {
    config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
    #unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config.allowUnfree = true; };
    };
  };
  };

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

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	environment.systemPackages = with pkgs; [
		vim 
		wget
		git
		k3d
		killall
		sqlite
		zsh
    oh-my-zsh
    cifs-utils
    keyutils
    usbutils
    xdg-utils

    # development
    rustc
    rustup
    cargo
    python3
    gcc
    gnumake
    cmake
    plantuml
    (with dotnetCorePackages; combinePackages [
      dotnet-sdk
      dotnet-runtime
      dotnet-aspnetcore
      dotnet-sdk_7
      dotnet-runtime_7
      dotnet-aspnetcore_7
      dotnet-sdk_8
      dotnet-runtime_8
      dotnet-aspnetcore_8
      ])
    (aspellWithDicts (dicts: with dicts; [ nl ]))
	];

  #programs.light.enable = true;

	# Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha1"
      ];
    };
  };

  # ydotool systemd service
  #systemd.user.services.ydotool.wantedBy = [ "default.target" ];

	#systemd.user.services = {
	#	ydotoold = {
	#		Unit = {
	#			Description = "An auto-input utility for wayland";
	#			Documentation = [ "man:ydotool(1)" "man:ydotoold(8)" ];
	#		};
	#		
	#		Service = {
	#			ExecStart = "/run/current-system/sw/bin/ydotoold --socket-path /tmp/ydotools";
	#		};

	#		Install = {
	#			WantedBy = ["default.target"];
	#		};
	#	};
	#};

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

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

	#security.pam.services.swaylock = {
	#	text = "auth include login";
	#};

  security.sudo.enable = true;
  security.sudo.extraRules = [
  {
    runAs = "root";
    users = [ "jacob" ];
    commands = [
    {
      command = "${pkgs.physlock}/bin/physlock"; 
      options = [ "NOPASSWD" ];
    }];
  }];

	# fonts
	fonts.packages = with pkgs; [
		noto-fonts
		fira-code
		jetbrains-mono
		font-awesome
    font-awesome_5
	];

  # firewall configuration
	networking.firewall.enable = true;
	networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  # enable antivirus clamav and
  # keep the signatures' database updated
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

	# shells
	environment.shells = with pkgs; [ zsh ];
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

  # battery life
  services.tlp.enable = true;

  # remote desktop connections
  # services.x2goserver.enable = true;

  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "sway";
  #services.xrdp.openFirewall = true;

  # backups
  services.borgbackup.jobs.jacobs-documents = {
    paths = "/home/jacob/Documents";
    encryption.mode = "none";
    environment.BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
    environment.BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /home/jacob/.ssh/id_ed25519";
    repo = "ssh://jacob@huis.duijzer.com//home/jacob/Backups";
    startAt = "daily";
  };

	# Automatic garbage collection
	nix.gc = {
		automatic = true;
		dates = "Weekly";
		options = "--delete-older-than 7d";
	};

	system.stateVersion = "23.11"; # Did you read the comment?
}

