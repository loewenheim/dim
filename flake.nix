{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixCargoIntegration = {
       url = "github:yusdacra/nix-cargo-integration";
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.nixCargoIntegration.lib.makeOutputs { root = ./.; };
}
