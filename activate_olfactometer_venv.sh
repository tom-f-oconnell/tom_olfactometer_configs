#!/usr/bin/env bash

# Assumes olfactometer source is under ~/src/olfactometer, and there is a
# virtual environment created under that source directory at
# ~/src/olfactometer/venv

# Detect whether script is being sourced, as activating the environment won't
# work otherwise.
# Works in my bash. First answer didn't work in some circumstances (e.g. running
# twice from same shell).
# From barroyo's answer https://stackoverflow.com/questions/2683279
if ! [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    echo "You must source this script, rather than just running it."
    echo "Call like: . activate_olfactometer_venv.sh"
    exit 1
fi

pushd . > /dev/null
cd ~/src/olfactometer
. venv/bin/activate
popd > /dev/null
