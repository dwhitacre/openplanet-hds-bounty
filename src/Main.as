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

void OnKeyPress(bool down, VirtualKey key) {
    if (down && key == Settings::Display.WindowVisibleKey) Settings::Display.ToggleVisibility();
}

void Main() {
    auto app = cast<CTrackMania>(GetApp());

    Api::Init();
    AccountMgr::Init(Settings::Config.FlatPlayerNames);

    auto teamNames = Settings::Config.TeamNames;
    auto playerNames = Settings::Config.PlayerNames;

    for (uint i = 0; i < playerNames.Length; i++) {
        auto teamName = (teamNames.Length - 1 < i) ? ("Team " + (i + 1)) : teamNames[i];
        Display::Teams.InsertLast(TeamVM(teamName, i));

        for (uint j = 0; j < playerNames[i].Length; j++) {
            Display::Players.InsertLast(PlayerVM(playerNames[i][j], i));
        }
    }
    
    while (true) {
        auto map = app.RootMap;
        string mapUid = Settings::Config.MapUid;
        if (!Settings_Config_LockMapUid && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) {
            mapUid = map.MapInfo.MapUid;
        }
        
        TimeMgr::UpdateTimes(mapUid);
        Display::Teams.SortAsc();

        sleep(15000);
    }
}
