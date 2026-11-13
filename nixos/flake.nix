{
  description = "shiko's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      hosts = builtins.attrNames (builtins.readDir ./hosts);
    in {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts (host:
        nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/${host} ];
        });
    };
}
