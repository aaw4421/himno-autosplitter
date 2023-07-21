state("Himno") {}

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Himno";
}

init {
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
        var stats = mono["PlayerStats"];

        vars.Helper["District"] = mono.Make<int>(stats, "script", "currDistrict");
        vars.Helper["InRun"] = mono.Make<bool>(stats, "script", "inRun");
        return true;
    });
}

update
{
    return (vars.Helper["District"].Old != vars.Helper["District"].Current);
}

start
{
    return (vars.Helper["InRun"].Old == false && vars.Helper["InRun"].Current == true);
}

split
{
    return (vars.Helper["District"].Current == 12 && vars.Helper["District"].Old == 11);
}

reset
{
    return ((vars.Helper["InRun"].Old == true && vars.Helper["InRun"].Current == false) &&
                vars.Helper["District"].Current == 1);
}

