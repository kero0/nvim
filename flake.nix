{
  inputs.nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      deps = pkgs:
        with pkgs; [
          neovim

          gcc
          git
          nodejs
          ripgrep

          nixd # not installed by mason
        ];
      nvim-env = system:
        let
          pkgs = import nixpkgs { inherit system; };
          env = pkgs.buildFHSEnv {
            name = "neovim-fhs";
            targetPkgs = deps;
          };
        in env;
    in rec {
      devShells = {
        x86_64-linux.default = (nvim-env "x86_64-linux").env;
        aarch64-darwin.default =
          let pkgs = import nixpkgs { system = "aarch64-darwin"; };
          in pkgs.mkShell { buildInputs = deps pkgs; };
      };
      packages = {
        x86_64-linux.default = let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; };
        in pkgs.writeShellScriptBin "nvim"
        "${nvim-env system}/bin/neovim-fhs nvim";
        aarch64-darwin.default =
          let pkgs = import nixpkgs { system = "aarch64-darwin"; };
          in pkgs.writeShellScriptBin "nvim" "${
            pkgs.symlinkJoin {
              name = "neovim-env";
              paths = deps pkgs;
            }
          }/bin/nvim";
      };
    };
}
