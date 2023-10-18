namespace Display {
    array<TeamVM@> Teams = {};
    array<PlayerVM@> Players = {};

    void RenderMenu() {
        if (UI::MenuItem("\\$db4" + Icons::Trophy + "\\$z " + Settings::Config.BountyName, "", Settings::Display.WindowVisible)) {
            Settings::Display.ToggleVisibility();
        }
    }

    void RenderName(const string &in name, string &in style = "\\$fff") {
        UI::Text(style + name);
    }
    
    void RenderTime(const int &in time, string &in style = "\\$fff") {
        UI::Text(style + (time > 0 ? Time::Format(time) : "-:--.---"));
    }

    void RenderAvgTime(const int &in time, string &in style = "\\$fff") {
        UI::Text(style + "(" + (time > 0 ? Time::Format(time) : "-:--.---") + ")");
    }

    void Render() {
        if (Settings::Display.HideWithIFace && !UI::IsGameUIVisible()) return;
        if (Settings::Display.HideWithOverlay && !UI::IsOverlayShown()) return;
        
        if (Settings::Display.WindowVisible) {
            if (Settings::Display.LockPosition) UI::SetNextWindowPos(int(Settings_Display_Anchor.x), int(Settings_Display_Anchor.y), UI::Cond::Always);
            else UI::SetNextWindowPos(int(Settings_Display_Anchor.x), int(Settings_Display_Anchor.y), UI::Cond::FirstUseEver);  
          
            int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;
            if (!UI::IsOverlayShown()) windowFlags |= UI::WindowFlags::NoInputs;
            
            UI::Begin(Settings::Config.BountyName, windowFlags);
            
            if (!Settings::Display.LockPosition) Settings::Display.UpdateAnchor(UI::GetWindowPos());
            
            UI::BeginGroup();
            
            UI::BeginTable("header", 1, UI::TableFlags::SizingFixedFit);
            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text(Settings::Config.BountyName);
            UI::EndTable();
            
            int numCols = 3;
            if (UI::BeginTable("table", numCols, UI::TableFlags::SizingFixedFit)) {
                for (uint i = 0; i < Teams.Length; i++) {
                  UI::TableNextRow();
                  
                  UI::TableNextColumn();
                  Teams[i].Name();
                  UI::TableNextColumn();
                  Teams[i].TotalTime();
                  UI::TableNextColumn();
                  Teams[i].AvgTime();
                  Teams[i].players.SortAsc();
                  
                  for (uint j = 0; j < Teams[i].players.Length; j++) {
                    UI::TableNextRow();
                    UI::TableNextColumn();
                    Teams[i].players[j].Name();
                    UI::TableNextColumn();
                    Teams[i].players[j].Time();
                  }

                  UI::TableNextRow();
                }
              
                UI::EndTable();
            }

            UI::EndGroup();     
            
            UI::End();
        }
    }
}

