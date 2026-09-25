using System;

// This is the base class
public class A
{
    // Constructor of class A
    public A(int value)
    {
        // Executes when object of A or B is created
        Console.WriteLine("Base constructor A()");
    }
}

// This class derives from class A
public class B : A
{
    // Constructor of class B
    // base(value) calls the constructor of class A first
    public B(int value) : base(value)
    {
        // This code executes after the base constructor
        Console.WriteLine("Derived constructor B()");
    }
}

class Program
{
    static void Main()
    {
        // Create an object of base class A
        A a = new A(0);

        // Create an object of derived class B
        // First A constructor executes, then B constructor
        B b = new B(1);

        Console.ReadKey();
    }
}

