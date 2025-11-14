{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    goVersion = 23;
    goOverlay = final: prev: {
      go = final."go_1_${toString goVersion}";
    };
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [goOverlay];
      };
    in {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          cobra-cli
          cue
          doppler
          go
          kubecolor
          kubectl
          kustomize_4
          yq-go
        ];
      };
    });
}
