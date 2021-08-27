namespace Demos {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Preparation;
    

    @EntryPoint()
    operation Start() : Unit {
        for i in 1..10 {
            BeamSplitter();
        }
        Message("*********");
        for i in 1..10 {
            MachZehnder1();
        }
        Message("*********");
        for i in 1..10 {
            MachZehnder2();
        }
        Message("*********");
    }

    operation BeamSplitter() : Unit {
        // allocate a new qubit in default state
        use photon = Qubit();

        // beam splitter
        H(photon);

        // result is a random Zero or One
        let detectorResult = M(photon) == Zero ? "d2" | "d1";

        Message(detectorResult);
        Reset(photon);
    }

    operation MachZehnder1() : Unit {
        // allocate a new qubit in default state
        use photon = Qubit();

        // beam splitter
        H(photon);

        // second beam splitter
        H(photon);

        // result is a certain Zero == "detector2" due to interference
        let detectorResult = M(photon) == Zero ? "d2" | "d1";

        Message(detectorResult);
        Reset(photon);
    }

    operation MachZehnder2() : Unit {
        // allocate a new qubit in default state
        use photon = Qubit();

        // beam splitter
        H(photon);

        // observe using the QND - it is a random Zero or One
        let qndResult = M(photon) == Zero ? "q2" | "q1";

        // second beam splitter
        H(photon);

        // result is a random Zero or One - interference disappears
        let detectorResult = M(photon) == Zero ? "d2" | "d1";

        Message($"{qndResult} | {detectorResult}");
        Reset(photon);
    }
}