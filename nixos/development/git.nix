{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName = "Jacob Duijzer";
		userEmail = "jacob@duijzer.com";
		
		extraConfig = {
			commit.gpgsign = true;
			gpg.format = "ssh";
			user.signingkey = "~/.ssh/id_ed25519.pub";
		};
	};
}
