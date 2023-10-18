array<TeamVM@> teams = {};

void RenderMenu() {
    Display::RenderMenu();
}

void Render() {
	Display::Render();
}

void setMinWidth(int width) {
	UI::PushStyleVar(UI::StyleVar::ItemSpacing, vec2(0, 0));
	UI::Dummy(vec2(width, 0));
	UI::PopStyleVar();
}

void Main() {
    auto app = cast<CTrackMania>(GetApp());

    Api::Init();
    
    while (true) {
        auto map = app.RootMap;
        string currentMapUid = Settings::Config.MapUid;
        if (!Settings_Config_LockMapUid && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) {
            currentMapUid = map.MapInfo.MapUid;
        }

        auto teamNames = Settings::Config.TeamNames;
        auto playerNames = Settings::Config.PlayerNames;
        teams = {};
        
        for (uint i = 0; i < playerNames.Length; i++) {
            auto teamName = (teamNames.Length - 1 < i) ? ("Team " + (i + 1)) : teamNames[i];
            teams.InsertLast(createTeamVM(teamName, playerNames[i], currentMapUid));
        }
        
        teams.SortAsc();
        sleep(500);
    }
}
