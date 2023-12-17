class GroupLeaderboard {
    string groupUid = "";
    array<LeaderboardZone@>@ tops = {};

    GroupLeaderboard() {}
    GroupLeaderboard(const string &in groupUid) {
        this.groupUid = groupUid;
    }

    string ToString() {
        array<string> tops = {};
        for (uint i = 0; i < this.tops.Length; i++) {
            tops.InsertLast(this.tops[i].ToString());
        }

        return KeyValuesToString({
            {"groupUid", this.groupUid},
            {"tops", ArrayToString(tops)}
        });
    }
}
