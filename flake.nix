{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          julia
          elixir
          erlang
        ];
        shellHook =  ''
          mkdir -p .nix-mix .nix-hex
          export MIX_HOME=$PWD/.nix-mix
          export HEX_HOME=$PWD/.nix-mix
          # make hex from Nixpkgs available
          # `mix local.hex` will install hex into MIX_HOME and should take precedence
          export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH
          export LANG=C.UTF-8
          export ELIXIR_ERL_OPTIONS="+fnu"
          export JULIA_DIR="${pkgs.julia}"
          export LD_LIBRARY_PATH="${pkgs.julia}/lib:$LD_LIBRARY_PATH"
          export PATH="${pkgs.julia}/bin:$PATH"
          
        '';
      };
    }
  );
}