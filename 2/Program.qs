namespace Demos {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Preparation;
    

    @EntryPoint()
    operation Start() : Unit {
        TestSet(PauliZ);

        Message("");

        TestSet(PauliX);
    }

    operation TestSet(basis : Pauli) : Unit {
        Message($"Measuring in {basis}");
        Message($"Prepared spin up");
        for i in 1..10 {
            SpinUp(basis);
        }
        Message("*********");
        Message($"Prepared spin down");
        for i in 1..10 {
            SpinDown(basis);
        }
        Message("*********");
        Message($"Prepared spin +");
        for i in 1..10 {
            SpinPlus(basis);
        }
        Message("*********");
        Message($"Prepared spin -");
        for i in 1..10 {
            SpinMinus(basis);
        }
    }

    operation SpinUp(basis : Pauli) : Unit {
        use electron = Qubit();

        let result = Measure([basis], [electron]);

        Message(ResolveResult(result, basis));
        Reset(electron);
    }

    operation SpinDown(basis : Pauli) : Unit {
        use electron = Qubit();

        X(electron);

        let result = Measure([basis], [electron]);

        Message(ResolveResult(result, basis));
        Reset(electron);
    }

    operation SpinPlus(basis : Pauli) : Unit {
        use electron = Qubit();

        H(electron);
    
        let result = Measure([basis], [electron]);

        Message(ResolveResult(result, basis));
        Reset(electron);
    }

    operation SpinMinus(basis : Pauli) : Unit {
        use electron = Qubit();

        X(electron);
        H(electron);

        let result = Measure([basis], [electron]);

        Message(ResolveResult(result, basis));
        Reset(electron);
    }

    function ResolveResult(result : Result, basis : Pauli) : String {
        if (basis == PauliX) {
            return result == Zero ? "+" | "-";
        }

        return result == Zero ? "up" | "down";
    }
}