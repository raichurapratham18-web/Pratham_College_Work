
using System;

// Base class
class X
{
    // Virtual methods
    public virtual void F()
    {
        Console.WriteLine("X.F");
    }

    public virtual void F2()
    {
        Console.WriteLine("X.F2");
    }
}


// Derived class Y
class Y : X
{
    // Sealed method
    // No further class can override F()
    public sealed override void F()
    {
        Console.WriteLine("Y.F");
    }

    // F2 is not sealed, so it can be overridden again
    public override void F2()
    {
        Console.WriteLine("Y.F2");
    }
}


// Derived class Z
class Z : Y
{
    // F() cannot be overridden because Y.F() is sealed

    // F2() can still be overridden
    public override void F2()
    {
        Console.WriteLine("Z.F2");
    }
}


// Main class
class SealedMethodTest
{
    static void Main()
    {
        // Object of class X
        X Obj1 = new X();

        // Calls X methods
        Obj1.F();
        Obj1.F2();


        // Object of class Y
        Y Obj2 = new Y();

        // Calls Y methods
        Obj2.F();
        Obj2.F2();


        // Object of class Z
        Z Obj3 = new Z();

        // F() comes from Y because Y.F() is sealed
        Obj3.F();

        // F2() is overridden by Z
        Obj3.F2();

        Console.ReadKey();
    }
}

