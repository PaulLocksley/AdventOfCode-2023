/*// See https://aka.ms/new-console-template for more information
//
using System.ComponentModel;
using System.Text.RegularExpressions;

bool isValidNum(string[] lines, int xstart,int xend, int y)
{
    Regex symbols = new Regex(@"[^0-9\.]");
    var start = Math.Max(0, xstart - 1);
    var end = Math.Min(lines[0].Length-1, xend + 2);
    var yStart = Math.Max(0, y - 1);
    var yEnd = Math.Min(lines.Length-1, y + 1);
    for (int i = yStart; i <= yEnd; i++)
    {
        if (symbols.IsMatch(lines[i][start..(end)]))
        {
            return true;
        }
    }
    
    return false;
}

int partOne(string[] lines)
{
    int sum = 0;
    for (int i = 0; i < lines.Length; i++)
    {
        int startNumber = -2;
        int endNumber = -2;
        for (int x = 0; x < lines[i].Length; x++) {
            if (lines[i][x] >= '0' && lines[i][x] <= '9')
            {
                if(startNumber == -2) { startNumber = x; }
                endNumber = x;
                
                if (x == lines[i].Length - 1 && isValidNum(lines, startNumber, endNumber, i)) { 
                    sum += Int32.Parse(lines[i].Substring(startNumber,endNumber - startNumber + 1));
                }
            }else if(startNumber != -2) {
                if (isValidNum(lines, startNumber, endNumber, i)) {
                    sum += Int32.Parse(lines[i].Substring(startNumber,endNumber - startNumber + 1));
                }
                startNumber = -2;
                endNumber = -2;
            }
        }
    }
    return sum;

}

int getNumberAt(string line, int x)
{
    int startX = x;
    int endX = x;
    for (int i = x; i >= 0; i--)
    {
        if (line[i] < '0' || line[i] > '9')
        {
            break;
        }
        startX = i;
    }

    for (int i = x; i < line.Length; i++)
    {
        if (line[i] < '0' || line[i] > '9')
        {
            break;
        }
        endX = i;
    }
    return Int32.Parse(line[startX..(endX+1)]);
}

int isValidGear(string[] lines, int gearX, int gearY)
{
    var start = Math.Max(0, gearX - 1);
    var end = Math.Min(lines[0].Length-1, gearX + 1);
    var yStart = Math.Max(0, gearY - 1);
    var yEnd = Math.Min(lines.Length-1, gearY + 1);
    int count = 0;
    List<(int x, int y)> cords = new List< (int x, int y) >();
    
    for (int y = yStart; y <= yEnd; y++)
    {
        for (int x = start; x <= end; x++)
        {
            if (lines[y][x] >= '0' && lines[y][x] <= '9')
            {
                cords.Add((x,y));
                count++;
                for (int subX = x + 1; subX < end+2; subX++)
                {
                    x = subX;
                    if (lines[y][subX] == '.' || lines[y][subX] == '*')
                    {
                        break;
                    }
                }
            }
        }
    }
    if(count != 2){
        return 0;
    }
    return cords.Select(x => getNumberAt(lines[x.y], x.x)).Aggregate((x, y) => x * y);
}
int partTwo(string[] lines)
{
    int count = 0;
    for (int y = 0; y < lines.Length; y++)
    {
        for (int x = 0; x < lines[y].Length; x++)
        {
            if (lines[y][x] == '*')
            {
                count+= isValidGear(lines, x, y);
            }
        }
    }

    return count;
}

int day = 3;
var input = File.ReadLines($"C:\\Projects\\AdventOfCode2022\\2023\\AdventOfCode-2023\\Day-{day}\\input.txt");
//var input = File.ReadLines($"C:\\Projects\\AdventOfCode2022\\2023\\AdventOfCode-2023\\Day-{day}\\test-input.txt");
Console.WriteLine(partOne(input.ToArray()));
Console.WriteLine(partTwo(input.ToArray()));*/