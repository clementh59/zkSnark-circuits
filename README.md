# ZK Snarks experiments using Circom

You can find Circom's documentation [here](https://docs.circom.io/getting-started/proving-circuits/#powers-of-tau).

## List of circuits

- `multiplier2` proves that someone knows a and b so that `a * b = x`, without revealing a nor b. x is public. It means that someone can prove, for example, that he knows a and b so that a * b = 101929, without revealing a nor b. To verify the correctness of the statement, we just need to check the output of the computation and check if it is equal to 101929. Please note that using a=1 and b=x works.
- `multiplier3` is the same as `multiplier2` but with 3 inputs (`in1 * in2 * in3 = out`).
- `multiplierN` is the same as `multiplier3` but with N inputs.

## Using the makefile

A makefile has been written to simplify the creation of circuit as well as the generation and verification of proofs. In order to use it, you'll always have to be in the root folder of the project.

If you do a lot of operations on a given circuit, you can just export the circuit name and number of constraint (useful for the power of tau ceremony):
```shell
export circuit=YOUR_CIRCUIT_NAME
export constraints=12
```
so that you are not forced to pass them as params each time you use the makefile.

## Setting up a new circuit

You can just run `make setup`.
Then, go to the freshly created folder and write your circuit.
Once it is written, follow the instructions of the section below.

## Modifying a circuit

When you modify the code of a circuit, you'll need to re-compile it.
You can run `make compile` to do it.

Then, to generate a proof, look at the section below.

## Generating a trusted setup

You just need to run `make trustedSetup`.

## Generating a proof

In order to generate a proof, you'll need a trusted setup. Please refer to the previous section.

You can use the makefile in order to generate a proof for a given circuit.

Here is what you'll need to do:
1. Customize `{YOUR_CIRCUIT_NAME}/{YOUR_CIRCUIT_NAME}_js/input.json` with your inputs
2. Go to the root folder
3. `make generateAndVerify`

You'll be asked to enter a few random messages.