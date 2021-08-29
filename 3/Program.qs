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
            use (one, two) = (Qubit(), Qubit()) {
                let correlated = ResultsAgree(PauliZ, one, two);
                Message($"Z: {correlated}");
            }
        }
        Message("");
        for i in 1..10 {
            use (one, two) = (Qubit(), Qubit()){
                let correlated = ResultsAgree(PauliX, one, two);
                Message($"X: {correlated}");
            }
        }
        Message("");
        Message("");
        Message("Quantum configured pair");
        for i in 1..10 {
            use (one, two) = (Qubit(), Qubit()) {
                PrepareEntangledState([one],[two]);
                let correlated = ResultsAgree(PauliZ, one, two);
                Message($"Z: {correlated}");
            }
        }
        Message("");
        for i in 1..10 {
            use (one, two) = (Qubit(), Qubit()) {
                PrepareEntangledState([one],[two]);
                let correlated = ResultsAgree(PauliX, one, two);
                Message($"X: {correlated}");
            }
        }
    }

    // operation ClassicalyConfiguredPair() : (Qubit, Qubit) {
    //     use (one, two) = (Qubit(), Qubit());
    //     return (one, two);
    // }

    // operation EntangledPair() : (Qubit, Qubit) {
    //     use (one, two) = (Qubit(), Qubit());
    //     PrepareEntangledState([one],[two]);
    //     return (one, two);
    // }

    operation ResultsAgree(basis : Pauli, one : Qubit, two : Qubit) : Bool {
        let result1 = IsResultOne(Measure([basis], [one]));
        let result2 = IsResultOne(Measure([basis], [two]));

        ResetAll([one, two]);
        return result1 == result2;
    }
}