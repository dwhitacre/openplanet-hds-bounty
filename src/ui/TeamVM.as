class TeamVM {
    string name = "Unknown Team";
    int id = 0;
    
    array<PlayerVM@> players
    {
        get const
        {
            array<PlayerVM@> p = {};
            for (uint i = 0; i < Display::Players.Length; i++) {
                if (Display::Players[i].teamId == this.id) p.InsertLast(Display::Players[i]);
            }
            p.SortAsc();
            return p;
        }
    }

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
    TeamVM(const string &in name, const int &in id) {
        this.name = name;
        this.id = id;
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
