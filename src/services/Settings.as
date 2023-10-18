[Setting category="Config" name="Team Names" multiline description="Place each team name on its own line. Reload the plugin after edit."]
string Settings_Config_TeamNames = "Orowoe's Team\nPurple Dragon Yeet\nMilky Way";

[Setting category="Config" name="Players" multiline description="Place each team's players names on their own line. The player names should be comma-separated values. Reload the plugin after edit."]
string Settings_Config_Players = "rebsterr, orowoe, sambertooth, w0lfx01_tm\njoeym145, dummy_tm, wayweewoo, danonthemoon.\ncosmos24, microwavef1, milkyfurry, omentrials";

[Setting category="Config" name="Map Uid" description="The map Uid from trackmania.io for the current bounty"]
string Settings_Config_MapUid = "N1MAyEEtoXNOBguy9PRWOww5Yn1";

[Setting category="Config" name="Lock Map Uid" description="This locks the display times to the above map uid. Leaving this unchecked will display the times for the map you are actively playing instead."]
bool Settings_Config_LockMapUid = true;

[Setting category="Config" name="Club Id" description="This is used to lookup player account ids. Probably shouldn't change it."]
string Settings_Config_ClubId = "50092";

[Setting category="Display" name="Window visible" description="To adjust the position of the window, click and drag while the Openplanet overlay is visible."]
bool Settings_Display_WindowVisible = true;

[Setting category="Display" name="Window visiblility hotkey"]
VirtualKey Settings_Display_WindowVisibleKey = VirtualKey(0);

[Setting category="Display" name="Hide when the game interface is hidden"]
bool Settings_Display_HideWithIFace = false;

[Setting category="Display" name="Hide when the Openplanet overlay is hidden"]
bool Settings_Display_HideWithOverlay = false;

[Setting category="Display" name="Window position"]
vec2 Settings_Display_Anchor = vec2(0, 170);

[Setting category="Display" name="Lock window position" description="Prevents the window moving when click and drag or when the game window changes size."]
bool Settings_Display_LockPosition = false;

namespace Settings {
    string safeString(const string &in setting) {
        auto str = setting.Trim();
        if (str.Length <= 0) throw("setting cannot be empty string");
        return str;
    }

    array<string> safeStringArray(const string &in setting, const string &in delim = "\n") {
        auto values = setting.Split(delim);
        for (uint i = 0; i < values.Length; i++) {
            values[i] = safeString(values[i]);
        }
        return values;
    }

    config Config = config();
    display Display = display();

    class config {
        config() {}

        string BountyName = "HD's Bounty";
 
        array<string> TeamNames
        {
            get const
            {
                return safeStringArray(Settings_Config_TeamNames);
            }
        }

        array<array<string>> PlayerNames
        {
            get const
            {
                array<string> playersOnTeam = safeStringArray(Settings_Config_Players);
                array<array<string>> players = {};
                for (uint i = 0; i < playersOnTeam.Length; i++) {
                    players.InsertLast(safeStringArray(playersOnTeam[i], ","));
                }
                return players;
            }
        }

        array<string> FlatPlayerNames
        {
            get const
            {
                array<string> players = {};
                for (uint i = 0; i < PlayerNames.Length; i++) {
                    for (uint j = 0; j < PlayerNames[i].Length; j++) {
                        players.InsertLast(PlayerNames[i][j]);
                    }
                }
                return players;
            }
        }

        string MapUid
        {
            get const
            {
                return safeString(Settings_Config_MapUid);
            }
        }

        bool LockMapUid 
        {
            get const
            {
                return Settings_Config_LockMapUid;
            }
        }

        string ClubId
        {
            get const
            {
                return safeString(Settings_Config_ClubId);
            }
        }

        void Debug() {
            print("BountyName: " + BountyName);
            print("TeamNames: ");
            print(TeamNames.ToJson());
            print("PlayerNames: ");
            print(PlayerNames.ToJson());
            print("MapUid: " + MapUid);
            print("LockMapUid: " + LockMapUid);
            print("ClubId: " + ClubId);
        }
    }

    class display {
        display() {}

        bool WindowVisible
        {
            get const
            {
                return Settings_Display_WindowVisible;
            }
        }

        VirtualKey WindowVisibleKey 
        {
            get const
            {
                return Settings_Display_WindowVisibleKey;
            }
        }

        bool HideWithIFace
        {
            get const
            {
                return Settings_Display_HideWithIFace;
            }
        }

        bool HideWithOverlay
        {
            get const
            {
                return Settings_Display_HideWithOverlay;
            }
        }

        vec2 Anchor
        {
            get const
            {
                return Settings_Display_Anchor;
            }
        }

        bool LockPosition
        {
            get const
            {
                return Settings_Display_LockPosition;
            }
        }

        void ToggleVisibility() {
            Settings_Display_WindowVisible = !Settings_Display_WindowVisible;
        }

        void UpdateAnchor(const vec2 &in pos) {
            Settings_Display_Anchor = pos;
        }
    }
}