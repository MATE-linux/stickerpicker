{
  description = "Python project environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          aiohttp
          yarl
          pillow
          telethon
          cryptg
          python-magic
          # добавьте ваши пакеты здесь
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonEnv
            pkgs.python3Packages.pip  # если нужен pip
            pkgs.python3Packages.virtualenv  # если нужен venv
          ];
          
          shellHook = ''
            echo "Python environment ready!"
            python --version
          '';
        };

      }
    );
}