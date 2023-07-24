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

start {
    return !old.InRun && current.InRun && current.District == 1;
}

split {
    return current.District == 12 && old.District == 11;
}

reset {
    return old.InRun && !current.InRun && current.District == 1;
}
