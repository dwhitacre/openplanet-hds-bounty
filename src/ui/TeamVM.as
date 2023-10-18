class TeamVM {
    string name = "Unknown Team";
    array<PlayerVM@> players = {};

    int totalTime 
    { 
        get const
        {
            if (this.players.Length < 1) return -1;
            int time = 0;
            for (uint i = 0; i < this.players.Length; i++) {
                time += this.players[i].time;
            }
            return time;
        }
    }

    int avgTime 
    { 
        get const
        {
            if (this.players.Length < 1) return -1;
            return this.totalTime / this.players.Length;
        }
    }

    TeamVM() {}
    TeamVM(const string &in name, const array<PlayerVM@> &in players) {
        this.name = name;
        this.players = players;
    }

    void TotalTime() {
        Display::RenderTime(this.totalTime);
    }

    void AvgTime() {
        Display::RenderAvgTime(this.avgTime);
    }

    void Name() {
        Display::RenderName(this.name);
    }

    int opCmp(TeamVM@ other) {
        return TimeMgr::CompareTimes(this.totalTime, other.totalTime);
    }
}

TeamVM@ createTeamVM(const string &in name, const array<string> &in players, const string &in mapId) {
    array<PlayerVM@> playerVMs = {};
    for (uint i = 0; i < players.Length; i++) {
        playerVMs.InsertLast(createPlayerVM(players[i], mapId));
    }
    return TeamVM(name, playerVMs);
}