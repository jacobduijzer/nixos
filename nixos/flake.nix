{
	description = "nixos+i3";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }: 
		let
			user = "jacob";
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
			lib = nixpkgs.lib;
		in {
			nixosConfigurations = {
				${user} = nixpkgs.lib.nixosSystem {
					inherit system;
					specialArgs = {inherit user;};
					modules = [ ./configuration.nix 
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.extraSpecialArgs = {inherit user;};
							home-manager.users.${user} = import ./home/home.nix;
						}
					];
				};
			};
		};
}
