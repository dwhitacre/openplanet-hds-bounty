class GroupLeaderboard {
    string groupUid = "";
    string mapUid = "";
    array<LeaderboardZone@>@ tops = {};

    GroupLeaderboard() {}
    GroupLeaderboard(const string &in groupUid) {
        this.groupUid = groupUid;
    }
    GroupLeaderboard(const string &in groupUid, const string &in mapUid) {
        this.groupUid = groupUid;
        this.mapUid = mapUid;
    }

    string ToString() {
        array<string> tops = {};
        for (uint i = 0; i < this.tops.Length; i++) {
            tops.InsertLast(this.tops[i].ToString());
        }

        return KeyValuesToString({
            {"groupUid", this.groupUid},
            {"mapUid", this.mapUid},
            {"tops", ArrayToString(tops)}
        });
    }
}
