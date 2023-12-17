class LeaderboardRanking {
    string accountId = "";
    string zoneId = "";
    string zoneName = "";
    int position = -1;
    string sp = "";

    LeaderboardRanking() {}
    LeaderboardRanking(const string &in accountId, const string &in zoneId, const string &in zoneName, int position, const string &in sp) {
        this.accountId = accountId;
        this.zoneId = zoneId;
        this.zoneName = zoneName;
        this.position = position;
        this.sp = sp;
    }

    int opCmp(LeaderboardRanking@ other) {
        return this.position - other.position;
    }

    string ToString() {
        return KeyValuesToString({
            {"accountId", this.accountId},
            {"zoneId", this.zoneId},
            {"zoneName", this.zoneName},
            {"position", Text::Format("%d", this.position)},
            {"sp", this.sp}
        });
    }
}

