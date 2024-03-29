{ config, pkgs, self, user, ... }:
{
	imports = [
		./alacritty.nix
    ../desktop/mako.nix
		../development/git.nix
		../misc/zsh.nix
    ../communication/teams.nix
    ../home/i3.nix
    ../misc/emacs.nix
	];

	home.username = "jacob";

	xdg = {
		enable = true;
		mimeApps = {
			enable = true;
			defaultApplications = {
				"application/x-extension-htm" = [ "vivaldi-stable.desktop" ];
				"application/x-extension-html" = [ "vivaldi-stable.desktop" ];
				"application/x-extension-shtml" = [ "vivaldi-stable.desktop" ];
				"application/x-extension-xht" = [ "vivaldi-stable.desktop" ];
				"application/x-extension-xhtml" = [ "vivaldi-stable.desktop" ];
				"application/x-extension-xhtml+xml" = [ "vivaldi-stable.desktop" ];
				"text/html" = [ "/etc/profiles/per-user/jacob/bin/vivaldi" ];
				"x-scheme-handler/chrome" = [ "vivaldi-stable.desktop" ];
				"x-scheme-handler/ftp" = [ "vivaldi-stable.desktop" ];
				"x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
				"x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
			};
		};
	};

  home.sessionVariables = {
	    BROWSER = "vivaldi";
      DOTNET_ROOT = "${pkgs.dotnet-sdk}";
	    TERMINAL = "alacritty";
	    NIXOS_OZONE_WL = "1";
	    QT_QPA_PLATFORMTHEME = "gtk3";
	    QT_SCALE_FACTOR = "1";
      GDK_BACKEND = "x11";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
	    _JAVA_AWT_WM_NONREPARENTING = "1";
	    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
	    QT_AUTO_SCREEN_SCALE_FACTOR = "0.5";
	    WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
	    WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
	    LIBVA_DRIVER_NAME = "i965";
	    WLR_RENDERER = "vulkan";
	    __NV_PRIME_RENDER_OFFLOAD="1";
	    GTK_USE_PORTAL = "1";
	    NIXOS_XDG_OPEN_USE_PORTAL = "1";
	    XDG_BIN_HOME = "\${HOME}/.local/bin";
      CMAKE_MAKE_PROGRAM = "/run/current-system/sw/bin/cmake";
    };

	fonts.fontconfig.enable = true;
	home.packages = [
		(pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
	];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
