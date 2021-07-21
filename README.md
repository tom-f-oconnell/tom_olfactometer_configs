
## Current protocol

### Initial setup

- **IMPORTANT**: if another olfactometer is connected and you need to take it off,
  **power off** the narrow left power strip (which currently has the power supply for
  Dhruv's olfactometer connected) **before** disconnecting the valves.

- Connect the outputs of the two 200 mL/min flow meters to the two 12-valve manifolds
  on my olfactometer (follow color codes). Connect the 1600 mL/min flow meter to the
  PTFE tube that will accept the outputs of the odor vials.

- Connect the two D-sub connectors that deliver power to the valves. **Each manifold
  gets exactly one connector**. There is yellow tape in three places: on the end of one
  of the D-sub cables, on the only connector that doesn't have red tape over it for the
  back manifold, and on one of the two D-Sub connectors mounted to the front/left
  manifold. **Connect the cable with yellow tape to the connector from the back manifold
  that also has yellow tape**. Connect the cable without yellow tape to the D-sub
  connector on the left manifold that also does not have yellow tape on it.

- Connect the two BNC cables connected to my Arduino (each should currently be
  labelled with yellow or green tape and have some kind of BNC adapter on the end) to
  the corresponding cables going to the ThorLabs data acquisition hardware (which should
  be color coded in the same manner with yellow and green tape).

- Disconnect the USB cable for the Arduino in Dhruv's olfactometer and connect the
  USB cable for the Arduino in mine (should have labelled yellow tape in it).

- Check that the valves between the wall vacuum valve and the vacuum funnel inside
  the dark box are allowing flow through the funnel, though when you set up a fly later
  **check that there is still sufficient suction to evacuate the excess saline**.
  I stick my finger in the funnel to form a seal and see that it has noticeable suction
  within a second or so.

- Remove the PID head from the dark box if it's in there.

- Open ThorSync / ThorImage **version 3.0** (the ones pinned to the taskbar) (and all
  other necessary software).

- Check that flow meters are set to 1600/200/200 mL/min. People who do experiments
  only using one manifold will typically have the higher flow rate set to 1800 mL,
  and typically this is all that needs to be changed.


#### Test the valves

- Open a Windows command prompt (the black icon on the task bar). You can use this
  same command prompt for all of the subsequent steps involving valves control / odor
  delivery.

  ```
  cd src
  cd tom_olfactometer_configs
  ```

- Run the valve test program and listen for clicks for **each valve**.

  ```
  olf-test-valves -u
  ```

  The valve numbers get printed to the terminal as the program executes, and each
  valve should be switched three consecutive times by default.

  The `-u` just re-uploads the firmware my code expects to the Arduino, so that if
  someone else was using their own Arduino scripts, it will still work. No subsequent
  commands will require this once you do it once. If you forget, the command will
  fail with some error.


### For each fly

If you ever want to stop stimulus delivery: go to the windows command prompt running the
stimulus delivery, press `Ctrl-C`, and then run `olf-upload`. If you don't run
`olf-upload`, the Arduino will keep running the rest of the stimulus delivery program,
even though nothing would be printed to the terminal.

1. Create a directory `D:\Tom\<YYYY-MM-DD>\<number of the current fly, starting at 1>`

   - Make sure ThorSync is saving to this numbered directory. **Start the ThorSync
     directory name at SyncData001**, and you should be able to let it autoincrement
     from there **within each fly**. For each new numbered fly directory, start the
     ThorSync output directory name at SyncData001 again.

2. Glomeruli diagnostic panel

   - In the Windows command prompt (that is still in the `src\tom_olfactometer_configs`
     directory):

     ```
     olf glomeruli_diagnostics.yaml
     ```

     It will print which odors you should connect to which valves, and will wait for you
     to press Enter before it starts the experiment. For each manifold, you will be
     exclusively using the valves on the on the top row (this will mean the front
     manifold will have the higher valve numbers and the back manifold will have the
     lower valve numbers).

     Note that there should be one solvent vial connected to each of the valves with a
     white tube downstream of it (there is one such valve per manifold). **There should
     always be solvent vials connected to these two valves**, though the program does
     not tell you to connect solvent here, as there should **always** be solvent
     connected downstream of these valves.

     First load the odor vials in to one of the 6-vial holders, then press each of the
     holders in one of the pairs of brackets on either side of the PTFE tube. Try to
     order the vials in the holders / angle them such that no tubing gets kinked or
     strained too much.

     **Wait to press Enter** until after you have the fly on and are done with the
     ThorImage setup described below.

     Check that **all three** of the mass flow controllers are achieving their set
     points.

   - ThorImage setup:
     - 192 x 192 pixels (drag the slider to get the values not available in the drop down)
 
     - ~5.9 - 6.3ish zoom. Pick a value when stepping with the piezo (as described below)
       such that there is at least a roughly 5% margin on all sides of the antennal lobe
       in case there is some slight drift.
 
     - Initial plane should be *just* low enough that it's still *roughly* circular and
       it's not just a couple glomeruli in plane. Set piezo step size to 12um in the live
       mode and step through from 0 to 48 um to make sure that the antennal lobe stays in
       the field of view in each plane.
 
     - ~2.5 power, though I was using ~3-4 before when it seems the scope power might
       have been slightly lower. Shouldn't matter too much.
 
     - Either antennal lobe should be fine (fly should be mounted on scope so it is
       facing you). Just pick the better looking one. If one has more inhomogenous
       baseline fluorescence (some bright glomeruli), and all other things look equally
       good, go for the side **without** this kind of elevated baseline.
 
     - (now switch to the capture plane) Streaming -> Stimulus
     - Raw data (not TIFF) output
     - Enable fast Z
     - Fast Z parameters: start=0, stop=48, step=12 (all same as when testing in live)
     - 1 flyback frame
 
     - Make sure the data is being saved to the numbered directory created before
     - Name this experiment `glomeruli_diagnostics`
 
     - When you ran `olf glomeruli_diagostics.yaml` above, it should have automatically
       copied the name of a `.yaml` file it generated to your clipboard. Click into the
       ThorImage experiment notes and paste the name of this generated file. If for some
       reason it's no longer in your clipboard, the terminal running the stimulus
       delivery will have the name of this file among the output it has printed so far.
 
       Also in the note field, include:
       ```
       odors: <month>/<day> (when the odors were prepared. labelled on vials.)
       surgeon: <your-name>
       ```
 
     - Make sure ThorSync is connected.
 
   - Make sure the curtain is closed as much as it can be. There should be a fair bit of
     overlap between the two sections of the curtain.

   - Turn the sensitivity on the manual manipulator all the way down and disable as many
     of the axes as you can.
 
   - Start ThorImage acquisition (and make sure ThorSync is also recording). **Now
     switch back to the terminal and press Enter to start stimulus delivery**.
 
3. Two separate odor pair experiments

   ```
   olf pair_concentration_grid.yaml
   ```

   The above command will randomly pick one of the two pairs we are currently focusing
   on, and print the appropriate random connections to make for it. Connect these odors.
   For each of these pair experiments, there will be a total of four solvent (pfo) vials
   connected: two of which will still be connected downstream of the white tubing, and
   two which will be randomly assigned to one of the normally-closed valves.

   Set up ThorImage as before. If necessary, make slight adjustments to make the initial
   plane look as it did in the previous experiment. Step through planes again on the
   piezo to check that the antennal lobe is still within the field of view.

   Name the ThorImage experiment with some abbreviation of the odors, underscore
   separated and no characters besides letters, numbers, underscore, and hyphen. For
   example, if the current pair was 1-hexanol and ethyl hexanoate, `ehex_and_1-6ol`
   would be appropriate.

   Again, paste the automatically-copied *generated* `.yaml` file into the ThorImage
   experiment notes. Other metadata is not as critical as long as it was entered on a
   previous experiment.

   Start ThorImage, check ThorSync is started, and *then* press Enter in the terminal to
   start the experiment.

   **When this experiment finishes, the program in the terminal will automatically print
   the connections for the next pair, and wait for Enter again.** Repeat steps above for
   the other pair.

4. "Anatomical" Z-stack to assist in glomeruli identifaction / registration

   The ThorImage setup is similar here, but with a few important differences:

   - **Turn on the red channel**, by turning the gain of the second PMT to a similar
     value to the gain of the green channel PMT (~10, or at least no more than 15).

     Also click the box (labelled "B", I think?) under the green box (labelled "A") on
     the right.

   - Set the resolution to 384x384 (384 = 192*2, to make for easy downsampling)

   - Set the intial plane higher, such that it just barely gets the top of the antennal
     lobe, rather than trying to capture much signal in the initial plane itself.

   - Capture settings:
     - Change mode from Streaming to Z/T-series mode

     - In Z-stack settings: **step=0.5um, stop=96um**

     - Enable the setting to allow streaming some number of planes at each Z depth, and
       configure it to stream 5 frames at each depth. This is to try to be able to
       filter out some motion.

     - Uncheck the time series streaming box beneath the Z-stack section.

     - Disconnect ThorSync (or just delete the data later)

     - Name the experiment `anat`


## Installation

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

