class PlayerVM {
    string accountId = "";
    string name = "Unknown Player";
    int time = -1;

    PlayerVM() {}
    PlayerVM(const string &in accountId, const string &in name, const int &in time) {
        this.accountId = accountId;
        this.name = name;
        this.time = time;
    }

    void Time() {
        Display::RenderTime(this.time);
    }

    void Name() {
        Display::RenderName(this.name);
    }

    int opCmp(PlayerVM@ other) {
        return TimeMgr::CompareTimes(this.time, other.time);
    }
}

PlayerVM@ createPlayerVM(const string &in name, const string &in mapUid) {
    auto accountId = AccountMgr::GetAccountId(name);
    auto time = TimeMgr::GetPBTime(accountId, mapUid);
    return PlayerVM(accountId, name, time);
}