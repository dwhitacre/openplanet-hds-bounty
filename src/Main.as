void RenderMenu() {
    Display::ToggleVisibility();
}

void Render() {
	Display::Draw();
}

void OnSettingsChanged() {
	Display::Draw();
}

void setMinWidth(int width) {
	UI::PushStyleVar(UI::StyleVar::ItemSpacing, vec2(0, 0));
	UI::Dummy(vec2(width, 0));
	UI::PopStyleVar();
}

void Main() {
    auto app = cast<CTrackMania>(GetApp());
    auto network = cast<CTrackManiaNetwork>(app.Network);

    // Teams::Load();

    // string currentMapUid = "";
    
    while (true) {
        // auto map = app.RootMap;
        
        // if(windowVisible && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) {
        //   team1.time = map.TMObjective_AuthorTime;
        //   team2.time = map.TMObjective_GoldTime;
        //   team3.time = map.TMObjective_SilverTime;

        //   currentMapUid = map.MapInfo.MapUid;

        //   auto info = FetchEndpoint(NadeoServices::BaseURLLive() + "/api/token/leaderboard/group/Personal_Best/map/"+mapId+"/top?length=1&onlyWorld=true");
          
        //   auto scoreMgr = network.ClientManiaAppPlayground.ScoreMgr;
        //   team1.time = scoreMgr.Map_GetRecord_v2(network.PlayerInfo.Id, map.MapInfo.MapUid, "PersonalBest", "", "TimeAttack", "");
          
        // } else if(map is null || map.MapInfo.MapUid == "") {
        // 	team1.time = -5;
        // 	team2.time = -4;
        // 	team3.time = -3;
        // 	currentMapUid = "";
        // }
        
        // times.SortAsc();
        
        sleep(500);
    }
}
