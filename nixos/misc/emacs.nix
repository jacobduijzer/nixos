{ configs, pkgs, ... }:
{
	programs.emacs = {
		enable = true;
		package = pkgs.emacs;
	};

	services.emacs = {
		enable = true;
		package = pkgs.emacs;
	}
}
