class PlayerVM {
    string accountId = "";
    string name = "Unknown Player";
    int teamId = 0;
    int time = -1;

    PlayerVM() {}
    PlayerVM(const string &in name, int teamId) {
        this.accountId = AccountMgr::GetAccountId(name);
        this.name = name;
        this.teamId = teamId;
    }

    void Time() {
        Display::RenderPlayerTime(this.time);
    }

    void Name() {
        Display::RenderPlayer(this.name);
    }

    int opCmp(PlayerVM@ other) {
        return TimeMgr::CompareTimes(this.time, other.time);
    }
}
