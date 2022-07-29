# ZK Snarks experiments using Circom

You can find circom doc [here](https://docs.circom.io/getting-started/proving-circuits/#powers-of-tau)

## List of circuits

- `multiplier2` proves that someone knows a and b so that a * b = 33, without revealing a nor b

## Using the makefile

A makefile has been written to simplify the creation of circuit as well as the generation and verification of proofs. In order to use it, you'll always have to be in the root folder of the project.

If you do a lot of operations on a given circuit, you can just export the circuit name:
`export circuit=YOUR_CIRCUIT_NAME` so that you are not forced to pass it as a param each time you use the makefile.

## Setting up a new circuit

You can just run `make setup circuit=YOUR_CIRCUIT_NAME`.
Then, go to the freshly created folder and write your circuit.
Once it is written, follow the instructions of the section below.

## Modifying a circuit

When you modify the code of a circuit, you'll need to re-compile it.
You can run `make compile circuit=YOUR_CIRCUIT_NAME` to do it.

Then, to generate a proof, look at the section below.

## Generating a proof

You can use the makefile in order to generate a proof for a given circuit.

Here is what you'll need to do:
1. Customize `{YOUR_CIRCUIT_NAME}/{YOUR_CIRCUIT_NAME}_js/input.json` with your inputs
2. Go to the root folder
3. `make generateAndVerify circuit=YOUR_CIRCUIT_NAME`

You'll be asked to enter a few random messages.