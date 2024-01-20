{ configs, pkgs, ... }:
{
	programs.emacs = {
		enable = true;
		package = pkgs.emacs29;
	};

	services.emacs = {
		enable = true;
		package = pkgs.emacs29;
	};
}
