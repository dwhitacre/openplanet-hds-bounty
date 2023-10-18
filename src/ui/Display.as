namespace Display {
    array<TeamVM@> Teams = {};
    array<PlayerVM@> Players = {};

    void RenderMenu() {
        if (UI::MenuItem("\\$db4" + Icons::Trophy + "\\$z " + Settings::Config.BountyName, "", Settings::Display.WindowVisible)) {
            Settings::Display.ToggleVisibility();
        }
    }

    void RenderStyledText(const string &in name, vec3 &in style = vec3(1, 1, 1)) {
        UI::Text(Text::FormatOpenplanetColor(style) + name);
    }

    void RenderTime(const int &in time, vec3 &in style) {
        RenderStyledText((time > 0 ? Time::Format(time) : "-:--.---"), style);
    }

    void RenderAvgTime(const int &in time, vec3 &in style) {
        RenderStyledText("(" + (time > 0 ? Time::Format(time) : "-:--.---") + ")", style);
    }

    void RenderBountyName() {
        RenderStyledText(Settings::Config.BountyName, Settings::Display.BountyNameColor);
    }

    void RenderHeader(const string &in name) {
        RenderStyledText(name, Settings::Display.HeaderColor);
    }

    void RenderTeam(const string &in name) {
        RenderStyledText(name, Settings::Display.TeamColor);
    }

    void RenderTeamTotalTime(const int &in time) {
        RenderTime(time, Settings::Display.TeamTotalTimeColor);
    }

    void RenderTeamAverageTime(const int &in time) {
        RenderAvgTime(time, Settings::Display.TeamAverageTimeColor);
    }

    void RenderPlayer(const string &in name) {
        RenderStyledText(name, Settings::Display.PlayerColor);
    }

    void RenderPlayerTime(const int &in time) {
        RenderTime(time, Settings::Display.PlayerTimeColor);
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
            
            if (Settings::Display.ShowBountyName)
            {
                UI::BeginTable("bountyName", 1, UI::TableFlags::SizingFixedFit);
                UI::TableNextRow();
                UI::TableNextColumn();
                RenderBountyName();
                UI::EndTable();
            }
            
            int numCols = Settings::Display.ShowTeamAverageTimes ? 3 : 2;
            if (UI::BeginTable("table", numCols, UI::TableFlags::SizingFixedFit)) {
                if (Settings::Display.ShowHeader) {
                    UI::TableNextRow();
                    
                    UI::TableNextColumn();
                    RenderHeader("Name");
                    UI::TableNextColumn();
                    RenderHeader("Time");

                    if (Settings::Display.ShowTeamAverageTimes) {
                        UI::TableNextColumn();
                        RenderHeader("Avg");
                    }
                }

                for (uint i = 0; i < Teams.Length; i++) {
                    UI::TableNextRow();
                    
                    UI::TableNextColumn();
                    Teams[i].Name();
                    UI::TableNextColumn();
                    Teams[i].TotalTime();

                    if (Settings::Display.ShowTeamAverageTimes) {
                        UI::TableNextColumn();
                        Teams[i].AvgTime();
                    }
                    
                    if (Settings::Display.ShowPlayersTimes) {
                        for (uint j = 0; j < Teams[i].players.Length; j++) {
                            UI::TableNextRow();
                            UI::TableNextColumn();
                            Teams[i].players[j].Name();
                            UI::TableNextColumn();
                            Teams[i].players[j].Time();
                        }
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

