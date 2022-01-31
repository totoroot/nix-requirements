# nix-requirements

This shell script converts a Python requirements file to a basic Nix shell configuration file.

As input it takes a list of Python requirements from the requirements.txt file and populates the skeleton in skeleton.nix to create a Nix shell configuration file shell.nix.

Currently there is no option to modify paths with e.g. command line arguments besides editing the variables in process.sh itself.

Also the script does not consider versions of Python packages specified in requirements.txt and instead ignores them completely.

This means that Python packages installed in the Nix shell environment might not be installed in the right version.
