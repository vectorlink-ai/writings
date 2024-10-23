{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bitviz.url = "github:vectorlink-ai/bitviz";

  };
  outputs = {nixpkgs, flake-utils, bitviz, ...}:
    flake-utils.lib.eachDefaultSystem (system:{
      devShells = {
        default = with nixpkgs.legacyPackages.${system};
        mkShell {
          buildInputs = [
            nodePackages.prettier
            gnuplot
            bitviz.packages.${system}.default
          ];
        };
      };
    });
}
