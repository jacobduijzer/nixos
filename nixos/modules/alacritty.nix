{ configs, pkgs, ... }:
{
	programs.alacritty = {
		enable = true;

		settings = {
			live_config_reload = true;
			font = {
				family = "JetBrainsMono Nerd Font";
				size = 10.0;
				offset = {
					x = 1;
					y = 1;
				};
			};

			colors = {
				primary = {
					background = "#0f1418";
					forground = "0xC6C6C6C4";
				};

				normal = {
					black = "0x10100E";
					red = "0xC40233";
					green = "0x009F6B";
					yellow = "0xFFD700";
					blue = "0x0087BD";
					magenta = "0x9A4EAE";
					cyan = "0x20B2AA";
					white = "0xC6C6C4";
				};
				bright = {
					black = "0x696969";
					red = "0xFF2400";
					green = "0x03C03C";
					yellow = "0xFDFF00";
					blue = "0x007FFF";
					magenta = "0xFF1493";
					cyan = "0x00CCCC";
					white = "0xFFFAFA";
				};
			};

			window = {
				title = "Terminal";
				padding = { 
					x = 20;
					y = 20;
				};
				dynamic_padding = true;
				
			};
		};
	};
}

