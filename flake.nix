{
  description = "raf's mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations."MBP" = nix-darwin.lib.darwinSystem {
      modules = [
        ./configuration.nix
        ./src/aerospace.nix
        ./src/brew.nix
        ./src/darwin.nix
        ./src/environment.nix
        ./src/fonts.nix
        ./src/neovim.nix
        ./src/toolset.nix
      ];
    };
  };
}
