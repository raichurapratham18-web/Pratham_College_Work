using System;

// Abstract base class
abstract class Test
{
    // Protected variable so derived classes can access it
    protected int a;

    // Abstract method
    // It must be implemented by derived classes
    public abstract void A();
}


// First derived class
class Example1 : Test
{
    // Override the abstract method
    public override void A()
    {
        Console.WriteLine("Example1.A");

        // Increase the value of a
        base.a++;
    }
}


// Second derived class
class Example2 : Test
{
    // Override the abstract method
    public override void A()
    {
        Console.WriteLine("Example2.A");

        // Decrease the value of a
        base.a--;
    }
}


// Main program
class Program
{
    static void Main()
    {
        // Reference Example1 through Test type
        Test test1 = new Example1();
        test1.A();

        // Reference Example2 through Test type
        Test test2 = new Example2();
        test2.A();

        Console.ReadKey();
    }
}

