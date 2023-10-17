namespace Display {
    void DrawName(const string &in name, string &in style = "\\$fff") {
        UI::Text(style + name);
    }
    
    void DrawTime(const int &in time, string &in style = "\\$fff") {
        UI::Text(style + (time > 0 ? Time::Format(time) : "-:--.---"));
    }

    void ToggleVisibility() {
        if (UI::MenuItem("\\$db4" + Icons::Trophy + "\\$z " + Settings_Config_BountyName, "", Settings_Display_WindowVisible)) {
            Settings_Display_WindowVisible = !Settings_Display_WindowVisible;
        }
    }

    void Draw() {
        auto app = cast<CTrackMania>(GetApp());
        auto map = app.RootMap;
        string currentMapUid = Settings_Config_MapId;
        if (!Settings_Config_LockMapId && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) {
            currentMapUid = map.MapInfo.MapUid;
        }
        
        if (Settings_Display_HideWithIFace && !UI::IsGameUIVisible()) {
            return;
        }
        
        if (Settings_Display_HideWithOverlay && !UI::IsOverlayShown()) {
            return;
        }
        
        if (Settings_Display_WindowVisible) {
            if (Settings_Display_LockPosition) {
                UI::SetNextWindowPos(int(Settings_Display_Anchor.x), int(Settings_Display_Anchor.y), UI::Cond::Always);
            } else {
                UI::SetNextWindowPos(int(Settings_Display_Anchor.x), int(Settings_Display_Anchor.y), UI::Cond::FirstUseEver);
            }
          
            int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;
            if (!UI::IsOverlayShown()) {
                windowFlags |= UI::WindowFlags::NoInputs;
            }
            
            UI::Begin(Settings_Config_BountyName, windowFlags);
            
            if (!Settings_Display_LockPosition) {
                Settings_Display_Anchor = UI::GetWindowPos();
            }
            
            UI::BeginGroup();
            
            UI::BeginTable("header", 1, UI::TableFlags::SizingFixedFit);
            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text(Settings_Config_BountyName);
            UI::EndTable();
            
            // int numCols = 2;
            // if (UI::BeginTable("table", numCols, UI::TableFlags::SizingFixedFit)) {
            //     // TODO draw teams and players
            //     // for (uint i = 0; i < times.Length; i++) {
            //     //   if (times[i].hidden) {
            //     //     continue;
            //     //   }   
            //     //   UI::TableNextRow();
                  
            //     //   UI::TableNextColumn();
            //     //   times[i].DrawName();
                  
            //     //   UI::TableNextColumn();
            //     //   times[i].DrawTime();
            //     // }
              
            //     UI::EndTable();
            // }

            UI::EndGroup();     
            
            UI::End();
        }
    }

    void Update() {

    }
}

