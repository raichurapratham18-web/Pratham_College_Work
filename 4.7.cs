using System;

// Sealed class
// A sealed class cannot be inherited by another class
sealed class A
{
    // Public data members
    public int x;
    public int y;
}


// Main class
class SealedTest2
{
    static void Main()
    {
        // Create an object of sealed class A
        A sc = new A();

        // Assign values to data members
        sc.x = 110;
        sc.y = 150;

        // Display the values
        Console.WriteLine("x = {0}, y = {1}", sc.x, sc.y);

        Console.ReadKey();
    }
}

