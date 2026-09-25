using System;

// User-defined exception class
class MyException : Exception
{
    // Constructor of MyException
    public MyException(string str) : base(str)
    {
        // User-defined exception message
        Console.WriteLine("User defined exception");
    }
}


class MyClient
{
    public static void Main()
    {
        try
        {
            // Throwing user-defined exception
            throw new MyException("my exception generated.");
        }
        catch (Exception e)
        {
            // Displaying exception message
            Console.WriteLine("Exception caught here: " + e.Message);
        }

        // This statement executes after exception handling
        Console.WriteLine("LAST STATEMENT");

        Console.ReadKey();
    }
}
