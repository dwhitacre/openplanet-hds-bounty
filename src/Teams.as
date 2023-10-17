namespace Teams {
    class Team {
        string Name = "Unknown Team";
        array<Player@> Players = {};

        int TotalTime 
        { 
            get const
            {
                if (this.Players.Length < 1) return -1;
                int time = 0;
                for (uint i = 0; i < this.Players.Length; i++) {
                    time += this.Players[i].Time;
                }
                return time;
            }
        }

        int AvgTime 
        { 
            get const
            {
                if (this.Players.Length < 1) return -1;
                return this.TotalTime / this.Players.Length;
            }
        }

        Team() {}

        Team(const string &in name) {
            this.Name = name;
        }

        int opCmp(Team@ other) {
            return compareTimes(this.TotalTime, other.TotalTime);
        }

        string ToString() {
            array<string> players = {};
            for (uint i = 0; i < this.Players.Length; i++) {
                players.InsertLast(this.Players[i].ToString());
            }

            return "{ " +
                string::Join({
                    decorateNameValue("Name", this.Name), 
                    decorateNameValue("TotalTime", this.TotalTime),
                    decorateNameValue("AvgTime", this.AvgTime),
                    decorateNameValue("Players", string::Join(players, ", ")),
                }, ", ") +
                " }";
        }
    }

    class Player {
        string AccountId = "";
        string Name = "Unknown Player";
        int Time = -1;

        Player() {}

        Player(const string &in accountId, const string &in name, const int &in time) {
            this.AccountId = accountId;
            this.Name = name;
            this.Time = time;
        }

        int opCmp(Player@ other) {
            return compareTimes(this.Time, other.Time);
        }

        string ToString() {
            return "{ " +
                string::Join({
                    decorateNameValue("AccountId", this.AccountId),
                    decorateNameValue("Name", this.Name),
                    decorateNameValue("Time", this.Time),
                }, ", ") +
                " }";
        }
    }

    int compareTimes(const int &in timeA, const int &in timeB) {
        if ((timeA >= 0) == (timeB >= 0)) {
            int64 diff = int64(timeA) - int64(timeB);
            return diff == 0 ? 0 : diff > 0 ? 1 : -1;
        } else {
            int64 diff = int64(timeB) - int64(timeA);
            return diff == 0 ? 0 : diff > 0 ? 1 : -1;
        }
    }

    string decorateNameValue(const string &in name, const string &in value) {
        return name + ": " + (value.Length == 0 ? "EMPTY" : value);
    }

    string decorateNameValue(const string &in name, const int &in value) {
        return decorateNameValue(name, Text::Format("%d", value));
    }

    bool isLoaded = false;
    array<Team@> teams = {};

    array<Team@> Get() {
        if (!isLoaded) Load();
        return teams;
    }

    array<string> getPlayerAccountIds(const array<string> &in playerNames) {
        array<string> accountIds = {};
		if (playerNames.Length == 0) return accountIds;

        for (uint i = 0; i < playerNames.Length; i++) {
            accountIds.InsertLast(Api::GetAccountId(playerNames[i].Trim()));
        }

        return accountIds;
    }

    void Load() {
        array<string> teamNames = Settings_Config_TeamNames.Split("\n");
        array<string> playerNamesByTeam = Settings_Config_Players.Split("\n");

        for (uint i = 0; i < playerNamesByTeam.Length; i++) {
            array<string> playerNames = playerNamesByTeam[i].Split(",");
            array<string> playerAccountIds = getPlayerAccountIds(playerNames);
            
            string teamName = ((teamNames.Length - 1 < i) ? ("Team " + (i + 1)) : teamNames[i]).Trim();
            Team team = Team(teamName);

            for (uint j = 0; j < playerNames.Length; j++) {
                string name = playerNames[j].Trim();
                team.Players.InsertLast(Player(playerAccountIds.Length < j + 1 ? "" : playerAccountIds[j], name, -1));
            }

            teams.InsertLast(team);
            trace(team);
        }

        isLoaded = true;
    }

    void UpdateTimes() {
        return;
    }
}