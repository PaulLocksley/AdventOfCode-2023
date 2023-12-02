// See https://aka.ms/new-console-template for more information
/*
using System.Text.RegularExpressions;

string GetNumber(string s)

    return s switch
    {
        "one" => "1",
        "two" => "2",
        "three" => "3",
        "four" => "4",
        "five" => "5",
        "six" => "6",
        "seven" => "7",
        "eight" => "8",
        "nine" => "9",
        _ => s
    };
}

Console.WriteLine("Hello, World!");
var input = File.ReadLines("C:\\Projects\\AdventOfCode2022\\2023\\AdventOfCode-2023\\Day-1\\input.txt");
var output = 0;
var p = new Regex("[0-9]|one|two|three|four|five|six|seven|eight|nine");
var lz = new Regex("[0-9]|one|two|three|four|five|six|seven|eight|nine",RegexOptions.RightToLeft);

foreach (var line in input)
{
    output += Int32.Parse($"{GetNumber(p.Match(line).ToString())}{GetNumber(lz.Match(line).ToString())}");
}
Console.WriteLine(output);
*/