{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixCargoIntegration = {
      url = "github:yusdacra/nix-cargo-integration";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.nixCargoIntegration.lib.makeOutputs {
      root = ./.;
      buildPlatform = "crate2nix";
      defaultOutputs = {
        package = "dim";
        app = "dim";
      };
      overrides.common = prev: {
        pkgs = prev.pkgs;
        
        runtimeLibs = prev.runtimeLibs
          ++ (with prev.pkgs; [ sqlite yarn npm ffmpeg ]);
          
        buildInputs = prev.buildInputs
          ++ (with prev.pkgs; [ openssl libva-full ]);
          
        nativeBuildInputs = prev.nativeBuildInputs ++ [ ];

        env = prev.env;
      };

      overrides.build = common: prev: {
        rootFeatures = prev.rootFeatures ++ [ "embed_ui" ];
        release = false;
        runTests = prev.runTests;
      };
    };
}
