setup:
	make checkParam
	mkdir ${circuit}; touch ${circuit}/${circuit}.circom

compile:
	make checkParam
	cd ${circuit} && circom ${circuit}.circom --r1cs --wasm --sym --c

generateAndVerify:
	make checkParam
	make generateWitness
	make tau1
	make tau2
	make phase2_1
	make phase2_2
	make phase2_3
	make phase2_4
	make phase2_5
	make verify

generateWitness:
	make checkParam
	cd ${circuit}/${circuit}_js && node generate_witness.js ${circuit}.wasm input.json witness.wtns

tau1:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs powersoftau new bn128 ${constraints} pot${constraints}_0000.ptau -v

tau2:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs powersoftau contribute pot${constraints}_0000.ptau pot${constraints}_0001.ptau --name="First contribution" -v

phase2_1:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs powersoftau prepare phase2 pot${constraints}_0001.ptau pot${constraints}_final.ptau -v

phase2_2:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs groth16 setup ../${circuit}.r1cs pot${constraints}_final.ptau ${circuit}_0000.zkey

phase2_3:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs zkey contribute ${circuit}_0000.zkey ${circuit}_0001.zkey --name="1st Contributor Name" -v

phase2_4:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs zkey export verificationkey ${circuit}_0001.zkey verification_key.json

phase2_5:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs groth16 prove ${circuit}_0001.zkey witness.wtns proof.json public.json

verify:
	make checkParam
	cd ${circuit}/${circuit}_js && snarkjs groth16 verify verification_key.json public.json proof.json

clean:
	make checkParam
	cd ${circuit}/${circuit}_js && rm pot* ${circuit}_* proof.json public.json verification_key.json witness.wtns

checkParam:
	if [[ -z "${circuit}" ]] ; then echo "Circuit is null" ; false ; fi
	if [[ -z "${constraints}" ]] ; then echo "Constraints is null" ; false ; fi