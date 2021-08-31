namespace Demos {

    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Preparation;
    

    @EntryPoint()
    operation Start() : Unit {
        Message("Classically configured pair");
        for i in 1..10 {
            ClassicallyPrepared(PauliZ);
        }
        Message("");
        for i in 1..10 {
            ClassicallyPrepared(PauliX);
        }
        Message("");
        Message("");
        Message("Quantum configured pair");
        for i in 1..10 {
            QuantumPrepared(PauliZ);
        }
        Message("");
        for i in 1..10 {
            QuantumPrepared(PauliX);
        }
    }

    operation ClassicallyPrepared(basis : Pauli) : Unit {
        use pair = Qubit[2];
        Message($"{basis}: {ResultsAgree(basis, pair)}");
    }

    operation QuantumPrepared(basis : Pauli) : Unit {
        use pair = Qubit[2];
        PrepareEntangledState([pair[0]], [pair[1]]);
        Message($"{basis}: {ResultsAgree(basis, pair)}");
    }

    operation ResultsAgree(basis : Pauli, pair : Qubit[]) : Bool {
        let result1 = IsResultOne(Measure([basis], [pair[0]]));
        let result2 = IsResultOne(Measure([basis], [pair[1]]));

        ResetAll(pair);
        return result1 == result2;
    }
}