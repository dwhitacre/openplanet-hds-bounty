[Setting category="Birthday Display" name="Show Bounty Name"]
bool S_Birthday_ShowBountyName = true;

[Setting category="Birthday Display" color name="Bounty Name"]
string S_Birthday_BountyName = "HD's Birthday Bounty";

[Setting category="Birthday Display" name="Bounty Name Rainbow"]
bool S_Birthday_BountyNameRainbow = true;

[Setting category="Birthday Display" name="Birthday Rainbow Color" hidden]
vec3 S_Birthday_RainbowColor = vec3(1, 0, 0);

[Setting category="Birthday Display" name="Birthday Rainbow Interval" min=0.f max=.03f description="Step interval for rainbow effect. Smaller numbers mean slower transitions."]
float S_Birthday_RainbowInterval = 0.01f;

[Setting category="Birthday Display" color name="Bounty Name Color"]
vec3 S_Birthday_BountyNameColor = vec3(1, 1, 1);

[Setting category="Birthday Display" name="Countdown Start Time"]
int64 S_Birthday_CountdownStartTime = 1708686000;

[Setting category="Birthday Display" name="Countdown Rainbow"]
bool S_Birthday_CountdownRainbow = false;

[Setting category="Birthday Display" color name="Countdown Color"]
vec3 S_Birthday_CountdownColor = vec3(1, 1, 1);

[Setting category="Birthday Display" name="Show Countdown" description="Disable to hide the countdown manually. Simulates the timer being at 0."]
bool S_Birthday_ShowCountdown = true;

[Setting category="Birthday Display" color name="Birthday Goal Player Name Color"]
vec3 S_Birthday_GoalPlayerNameColor = vec3(1, 1, 1);

[Setting category="Birthday Display" color name="Birthday Goal Player Score Color"]
vec3 S_Birthday_GoalPlayerScoreColor = vec3(1, 1, 1);

[Setting category="Birthday Display" color name="Discord Link"]
string S_Birthday_DiscordLink = "https://discord.gg/yR5EtqAWW7";