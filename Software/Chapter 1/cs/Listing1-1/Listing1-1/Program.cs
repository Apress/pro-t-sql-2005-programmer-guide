using System;
using System.IO;

namespace APress.Samples
{
    class Program
    {
        static void Main(string[] args)
        {
            // Opens the Person_Contact file for input. The file is located
            // two directories above the bin\* directory, so a relative path
            // is used.
            StreamReader sr = new StreamReader("..\\..\\Person_Contact.txt");
            string FirstName = null;
            // Reads in each first name
            while ((FirstName = sr.ReadLine()) != null)
            {
                // Writes each first name to the console
                Console.WriteLine(FirstName);
            }
            // Dispose of the StreamReader
            sr.Dispose();
            // Wait for user to press a key to exit
            Console.WriteLine("Press a key to end");
            Console.ReadKey();
        }
    }
}
