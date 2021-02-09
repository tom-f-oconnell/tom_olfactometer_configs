
### Usage

1. Install my [olfactometer repo](https://github.com/tom-f-oconnell/olfactometer)
   , following instructions in linked README.

2. Clone this repo.

  ```
  git clone https://github.com/tom-f-oconnell/tom_olfactometer_configs
  ```

3. Set the environment variable `OLFACTOMETER_HARDWARE_DIR` to
   `<where-you-cloned-this-repo>/hardware`. On Linux, you can add a line like:

   ```
   # (modify path to point to where you cloned this repo)
   export OLFACTOMETER_HARDWARE_DIR="$HOME/src/tom_olfactometer_configs/hardware"
   ```

   ...to the end of your `~/.bashrc`.

   For how to do this on Windows, see instructions in the link to my
   olfactometer repo above.

4. Using the same method as in step 3 above, set `OLFACTOMETER_DEFAULT_HARDWARE`
   to the prefix of the file under the `hardware` directory that you want to
   use.

   For example, to use `./hardware/single_manifold2.yaml` as the default
   hardware definition, set this variable to `single_manifold2`.

See link to olfactometer repo above for commands to run the olfactometer or test
the valves.

