// See https://aka.ms/new-console-template for more information

using System.Text.RegularExpressions;

Dictionary<string, int> countCubes(string s)
{
    var rdict = new Dictionary<string, int> {{"red",0}, {"green",0}, {"blue",0} };
    var p = new Regex(@"(\d+)\s+(\w+)");
    foreach (var g in p.Matches(s).Select(m => m.Groups.Values.Select(h => h.ToString()).ToArray()))
    {
            rdict[g[2]] = Math.Max(Int32.Parse(g[1]),rdict[g[2]]);
    }
    return rdict;
}

bool isValidGame(IDictionary<string, int> game, IDictionary<string, int> limit)
{
    foreach (var kv in game)
    {
        if (limit[kv.Key] < kv.Value)
        {
            return false;
        }
    }

    return true;
}

int partOne(IEnumerable<string> lines)
{
    var limit = new Dictionary<string, int> { {"red",12}, {"green",13}, {"blue",14} };
    var linenumberrx = new Regex(@"Game (\d+):");
    return lines.Where(x => isValidGame(countCubes(x), limit)).Aggregate(0,(x,y) =>
        x += Int32.Parse(linenumberrx.Match(y).Groups.Values.ToArray()[1].ToString())
    );
}

int partTwo(IEnumerable<string> lines)
{
    return lines.Select(countCubes).Select(kv =>
        kv["red"] * kv["green"] * kv["blue"]
    ).Aggregate((x, y) => x + y);
}

var input = File.ReadLines("C:\\Projects\\AdventOfCode2022\\2023\\AdventOfCode-2023\\Day-2\\input.txt");
//var input = File.ReadLines("C:\\Projects\\AdventOfCode2022\\2023\\AdventOfCode-2023\\Day-2\\test-input.txt");
Console.WriteLine(partOne(input));
Console.WriteLine(partTwo(input));