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

    for (uint i = 0; i < Settings::Config.PlayerNames.Length; i++) {
        auto teamName = (Settings::Config.TeamNames.Length - 1 < i) ? ("Team " + (i + 1)) : Settings::Config.TeamNames[i];
        Display::Teams.InsertLast(TeamVM(teamName, i));

        for (uint j = 0; j < Settings::Config.PlayerNames[i].Length; j++) {
            Display::Players.InsertLast(PlayerVM(Settings::Config.PlayerNames[i][j], i));
        }
    }
    
    while (true) {
        auto map = app.RootMap;

        TimeMgr::UpdateTimes((!Settings_Config_LockMapUid && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) ? map.MapInfo.MapUid : Settings::Config.MapUid);
        for (uint i = 0; i < Display::Teams.Length; i++) {
            Display::Teams[i].Clear();
        }
        Display::Teams.SortAsc();

        sleep(15000);
    }
}
