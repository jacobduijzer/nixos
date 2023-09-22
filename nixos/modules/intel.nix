{ config, pkgs, lib, input, user, ... }:
{
	services.xserver = {
		videoDrivers = [ "intel" ];
		
		config = ''
			Section "Device"
				Identifier "Intel Graphics"
				Driver "intel"
				#Option "NoAccel" "True"  
				Option "AccelMethot	"sna"
				#Option "DRI" "False"
				Option	"TearFree"	"true"
			EndSection
		'';

		hardware.opengl.enable = true;
		hardware.opengl.driSupport = true;
		hardware.opengl.driSupport32Bit = true;
	};
}
