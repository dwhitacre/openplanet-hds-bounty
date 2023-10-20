class TeamVM {
    string name = "Unknown Team";
    int id = 0;

    array<PlayerVM@> cachedPlayers = {};
    array<PlayerVM@>@ players
    {
        get
        {
            if (cachedPlayers.Length > 0) return cachedPlayers;
            for (uint i = 0; i < Display::Players.Length; i++) {
                if (Display::Players[i].teamId == this.id) cachedPlayers.InsertLast(Display::Players[i]);
            }
            cachedPlayers.SortAsc();
            return cachedPlayers;
        }
    }

    int totalTime 
    { 
        get
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
        get
        {
            if (this.players.Length < 1) return -1;
            return this.totalTime / this.players.Length;
        }
    }

    TeamVM() {}
    TeamVM(const string &in name, const int &in id) {
        this.name = name;
        this.id = id;
    }

    void Clear() {
        cachedPlayers.RemoveRange(0, cachedPlayers.Length);
    }

    void TotalTime() {
        Display::RenderTeamTotalTime(this.totalTime);
    }

    void AvgTime() {
        Display::RenderTeamAverageTime(this.avgTime);
    }

    void Name() {
        Display::RenderTeam(this.name);
    }

    int opCmp(TeamVM@ other) {
        return TimeMgr::CompareTimes(this.totalTime, other.totalTime);
    }
}
