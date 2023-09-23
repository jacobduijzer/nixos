{ config, pkgs, ... }:
let 
	p10kTheme = ./p10k-theme.zsh;
in
{
	programs.zsh = {
		enable = true;

		initExtra = ''
			[[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
		'';
		zplug = {
			enable = true;
			plugins = [
				{ name = "zsh-users/zsh-autosuggestions"; }
				{
					name = "romkatv/powerlevel10k"; 
					tags = [ as:theme depth:1 ];
				}
			];
		};
	};
}
