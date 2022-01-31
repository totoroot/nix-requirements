{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    python38
    python38Packages.matplotlib
    python38Packages.pandas
  ];
}
