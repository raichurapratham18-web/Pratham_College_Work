using System;

namespace StaticVarApplication
{
    class StaticVar
    {
        // Static variable
        public static int num;

        // Constructor
        // It is automatically called whenever an object is created
        public StaticVar()
        {
            num++;
        }

        // Static method to return the value of num
        public static int getNum()
        {
            return num;
        }
    }

    class StaticTester
    {
        static void Main(string[] args)
        {
            // Creating three objects
            // Constructor is called three times
            StaticVar s1 = new StaticVar();
            StaticVar s2 = new StaticVar();
            StaticVar s3 = new StaticVar();

            // Calling static method to display num
            Console.WriteLine("Variable num: {0}", StaticVar.getNum());

            Console.ReadKey();
        }
    }
}

