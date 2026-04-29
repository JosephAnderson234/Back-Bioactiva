{
  description = "Back-Bioactiva NestJS development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            nodejs_22
            openssl
            pkg-config
            pnpm
            python3
          ];

          shellHook = ''
            export NODE_ENV=''${NODE_ENV:-development}
            export PRISMA_HIDE_UPDATE_MESSAGE=1
            echo "Back-Bioactiva ready. Use pnpm install, pnpm run start:dev, or pnpm run build."
          '';
        };

        formatter = pkgs.alejandra;
      });
}