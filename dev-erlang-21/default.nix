let
  stearsPackages =
    builtins.fetchGit {
      name = "stears-packages";
      url = https://github.com/philipstears/nixpkgs-stears/;
      rev = "fc603b110399712e7cc92a2c2a62b7694cc1778c";
    };

  nixPackages =
    import <nixpkgs> {
      overlays = [
        # NOTE: do not specify {} here otherwise
        # we'll get infinite recursion errors
        (import stearsPackages)
      ];
    };
in

with nixPackages;

stdenv.mkDerivation {
  name = "dev-erlang-21";
  buildInputs = [
    pkgs.devPackages.erlang-21-2-4.erlang
    pkgs.devPackages.erlang-21-2-4.rebar3-9
  ];
}

