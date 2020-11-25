#!/usr/bin/env bash

# Hacky script to reinstall (development install, not Docker) of my olfactometer
# library, using the virtual environment assumed to be at:
# ~/src/olfactometer/venv

# After running this script, this virtual environment should be active.

pushd . > /dev/null

# If we are in a venv, deactivate it. No mind payed to possible conda envs.
if command -v deactivate &> /dev/null
then
    deactivate
fi

cd ~/src/olfactometer
# So this will work for the subsequent pip commands, but unless this script is
# sourced, the environment won't be active at the end of this script.
# TODO maybe also require this script is run by sourcing, as in the activate
# script here
. venv/bin/activate
pip uninstall olfactometer -y
pip install .

popd > /dev/null
