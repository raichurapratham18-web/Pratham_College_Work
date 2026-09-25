using System;

class MyClient
{
    public static void Main()
    {
        // Variable x contains zero
        int x = 0;

        try
        {
            // This statement causes DivideByZeroException
            int div = 100 / x;

            // This line will not execute because exception occurs above
            Console.WriteLine(div);
        }
        catch (DivideByZeroException)
        {
            // Handles division by zero exception
            Console.WriteLine("Cannot divide by zero.");
        }
        finally
        {
            // Finally block always executes
            Console.WriteLine("Finally block executed.");
        }

        Console.ReadKey();
    }
}

