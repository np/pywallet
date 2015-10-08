with import <nixpkgs> {};
with pkgs.python27Packages;

buildPythonPackage {
  name = "impurePythonEnv";
  buildInputs = [
     python27Full
     python27Packages.bsddb
     python27Packages.pycrypto
  ];
  src = null;
  # When used as `nix-shell --pure`
  shellHook = ''
    LD_LIBRARY_PATH=
    for i in $nativeBuildInputs; do
      LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$i/lib
    done
    export LD_LIBRARY_PATH
    export TERM=linux
    unset http_proxy
    export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
#exec zsh
  '';
  # used when building environments
  extraCmds = ''
    unset http_proxy # otherwise downloads will fail ("nodtd.invalid")
    export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-bundle.crt
  '';
}
