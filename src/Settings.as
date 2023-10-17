[Setting category="Config" name="Bounty Name"]
string Settings_Config_BountyName = "HD's Bounty";

[Setting category="Config" name="Team Names" multiline description="Place each team name on its own line."]
string Settings_Config_TeamNames = "Orowoe's Team\nPurple Drage Yeet\nMilky Way";

[Setting category="Config" name="Players" multiline description="Place each team's players names on their own line. The player names should be comma-separated values."]
string Settings_Config_Players = "rebsterr, orowoe, sambertooth, w0lfx01_tm\njoeym145, dummy_tm, wayweewoo, danonthemoon.\ncosmos24, microwavef1, milkyfurry, omentrials";

[Setting category="Config" name="Map Id" description="The map id for the current bounty"]
string Settings_Config_MapId = "135425";

[Setting category="Config" name="Lock Map Id" description="This locks the display times to the above map id. Leaving this unchecked will display the times for the map you are actively playing instead."]
bool Settings_Config_LockMapId = true;

[Setting category="Config" name="Club Id" description="This is used to lookup player account ids. Probably shouldn't change it."]
int Settings_Config_ClubId = 50092;

[Setting category="Display Settings" name="Window visible" description="To adjust the position of the window, click and drag while the Openplanet overlay is visible."]
bool Settings_Display_WindowVisible = true;

[Setting category="Display Settings" name="Window visiblility hotkey"]
VirtualKey Settings_Display_WindowVisibleKey = VirtualKey(0);

[Setting category="Display Settings" name="Hide when the game interface is hidden"]
bool Settings_Display_HideWithIFace = false;

[Setting category="Display Settings" name="Hide when the Openplanet overlay is hidden"]
bool Settings_Display_HideWithOverlay = false;

[Setting category="Display Settings" name="Window position"]
vec2 Settings_Display_Anchor = vec2(0, 170);

[Setting category="Display Settings" name="Lock window position" description="Prevents the window moving when click and drag or when the game window changes size."]
bool Settings_Display_LockPosition = false;