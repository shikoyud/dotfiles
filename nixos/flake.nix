{
  description = "shiko's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # the dismess repo, read from the checkout on macmini (it's a private GitHub repo, so this
    # avoids needing GitHub credentials while building). Only used for the voice relay
    # (modules/dismess.nix). After a `git pull` in ~/dismess:  nix flake update dismess
    dismess = { url = "git+file:///home/shiko/dismess?ref=main"; flake = false; };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      hosts = builtins.attrNames (builtins.readDir ./hosts);
    in {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts (host:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # lets modules use the inputs above
          modules = [ ./hosts/${host} ];
        });
    };
}
