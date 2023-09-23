{ config, pkgs, ... }:
{
	programs.zsh = {
		enable = true;

		zplug = {
			enable = true;
			plugins = [
				{ name = "zsh-users/zsh-autosuggestions"; }
				{ name = "romkatv/powerlevel10k"; }
			];
		};
	};
}
