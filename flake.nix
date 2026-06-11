{
  description = "Nix flake for MestReNova";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      overlays.default = self: super: {
        mnova = super.callPackage ./packages/mnova.nix { };
      };
      packages.${system}.default = pkgs.callPackage ./packages/mnova.nix { };
    };
}
