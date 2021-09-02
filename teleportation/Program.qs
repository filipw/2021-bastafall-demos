namespace teleportation {

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Logical;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Random;

    @EntryPoint()
    operation Start() : Unit {
        Message("Teleporting |+>");
        Teleport(true);
    }

    operation Teleport(signToSend : Bool) : Unit {
        // message represents the quantum state to teleport
        // resource represents the qubit that will be used as teleportation resource
        // target represents the qubit onto which the message will be teleported
        use (message, resource, target) = (Qubit(), Qubit(), Qubit());

        // prepare |-> or |+>
        if (signToSend == false) { X(message); }
        H(message);

        // create entanglement between resource and target
        H(resource);
        CNOT(resource, target);

        // reverse Bell circuit on message and resource
        CNOT(message, resource);
        H(message);

        // mesaure message and resource
        // to complete the Bell measurement
        let messageResult = MResetZ(message);
        let resourceResult = MResetZ(resource);

        // if we got |00>, there is nothing to do on the target
        if messageResult == Zero and resourceResult == Zero { 
            Message("Measured |00>, applying I");
            I(target); 
        } 

        // if we got |01>, we need to apply X on the target
        if messageResult == Zero and resourceResult == One { 
            Message("Measured |01>, applying X");
            X(target); 
        } 

        // if we got |10>, we need to apply Z on the target
        if messageResult == One and resourceResult == Zero { 
            Message("Measured |10>, applying Z");
            Z(target); 
        } 

        // if we got |11>, we need to apply XZ on the target
        if messageResult == One and resourceResult == One { 
            Message("Measured |11>, applying XZ");
            X(target); 
            Z(target); 
        } 
        
        let teleportedResult = MResetX(target);
        Message("Teleported state was measured to be: " + (IsResultOne(teleportedResult) ? "|->" | "|+>"));
    }
}