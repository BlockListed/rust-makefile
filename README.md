# About
A simple rust makefile. Intended to automate tasks like packaging, installing release and debug builds, and checking files.
Uses Cargo for building, getting dependencies, etc, so no complicated syntax.

# Setup
Replace variables at the top of the Makefile with the things for your project. Currently only 1 executable is supported and no other data, but that can be easily added to the final archive and install file.
Move dist-scripts and edited Makefile to project. dist-scripts contains install script for archive, including install and uninstall.
