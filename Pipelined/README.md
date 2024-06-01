# To do:
 - Redesign counter method in Hazard Unit as it might not be necessary for enabling the control signals
 - See if you can create a better method for solving the initialzation issues in the regsiters dividing the Execute and Memory stages
 - Add comments to Hazard Unit describing modifications
    - Counter is used to ensure that enough cycles have passed for generated hazard signals to be valid (if need be based on first TODO item)
    - StallF and StallD flip-flop circuitry ensure that the signals are activated on the rising-edge of the cycle they are required. This is done by delaying them a half-period to ensure they start a half-cycle before the rising-edge and are deactivated a half-cycle after.
    - The FlushD and FlushE signals contain circuitry to delay their signals by 1.5 cycles to ensure they are not activated before the contents of the pipeline registers can be transferred from one stage to another. Buffers to ensure introduce delays to mitigate timing issues related to signal propagation and the reset pins on the registers operate asychronously causing trasnfers to be erased.
    - The clock starts high due to a lack of propagation delay for reading the instrunction memory. This is necessary to match the 5-stage design where each stage takes a cycle to complete. The other designs start with the clock low.
- Remove unnecessary files from directory structure.
