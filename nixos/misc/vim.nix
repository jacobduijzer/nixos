{ pkgs, ... }:
{
	environment.variables = { EDITOR = "vim"; };

	environment.systemPackages = with pkgs; [
		((vim_configurable.override {  }).customize {
			name = "vim";
			# Install plugins for example for syntax highlighting of nix files
			vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
				start = [ vim-nix vim-lastplace ];
				opt = [];
			};

			vimrcConfig.customRC = ''
set nocompatible
set number
set ruler
set autoindent
set laststatus=2
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshowmode
syntax on
'';
			}
		)];
}
