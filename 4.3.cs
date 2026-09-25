using System;

// =====================================================
// TASK 1: Create a class
// Person is the parent/base class
// =====================================================
class Person
{
    // =================================================
    // TASK 2: Data members with different access levels
    // =================================================

    private string name;       // Private data member
    protected int age;         // Protected data member
    public string city;        // Public data member


    // =================================================
    // TASK 3: Public methods to work on data members
    // =================================================

    // Public method to set the private name
    public void SetName(string name)
    {
        this.name = name;
    }

    // Public method to set the protected age
    public void SetAge(int age)
    {
        this.age = age;
    }

    // Public method to display Person details
    public void DisplayPerson()
    {
        Console.WriteLine("Name : " + name);
        Console.WriteLine("Age  : " + age);
        Console.WriteLine("City : " + city);
    }
}


// =====================================================
// TASK 4: Create another class which inherits Person
// Student is the child/derived class
// =====================================================
class Student : Person
{
    // =================================================
    // TASK 5: Data members of the second class
    // =================================================

    private int rollNo;         // Private data member
    protected string course;    // Protected data member
    public string college;      // Public data member


    // =================================================
    // TASK 6: Public methods for Student data members
    // =================================================

    // Public method to set private roll number
    public void SetRollNo(int rollNo)
    {
        this.rollNo = rollNo;
    }

    // Public method to set protected course
    public void SetCourse(string course)
    {
        this.course = course;
    }

    // Public method to display Student details
    public void DisplayStudent()
    {
        Console.WriteLine("Roll No : " + rollNo);
        Console.WriteLine("Course  : " + course);
        Console.WriteLine("College : " + college);
    }
}


// =====================================================
// TASK 7: Create Demo class with Main method
// =====================================================
class Demo
{
    static void Main()
    {
        // =================================================
        // TASK 8: Create first object of Student class
        // =================================================

        Student s1 = new Student();

        // Setting inherited Person class data
        s1.SetName("Rahul");
        s1.SetAge(20);
        s1.city = "Rajkot";

        // Setting Student class data
        s1.SetRollNo(101);
        s1.SetCourse("BCA");
        s1.college = "ABC College";


        // Calling methods using first object
        Console.WriteLine("----- Student 1 -----");

        s1.DisplayPerson();
        s1.DisplayStudent();


        Console.WriteLine();


        // =================================================
        // Create second object of Student class
        // =================================================

        Student s2 = new Student();

        // Setting inherited Person class data
        s2.SetName("Amit");
        s2.SetAge(21);
        s2.city = "Ahmedabad";

        // Setting Student class data
        s2.SetRollNo(102);
        s2.SetCourse("BCA");
        s2.college = "XYZ College";


        // Calling methods using second object
        Console.WriteLine("----- Student 2 -----");

        s2.DisplayPerson();
        s2.DisplayStudent();


        // Wait for user input
        Console.ReadKey();
    }
}