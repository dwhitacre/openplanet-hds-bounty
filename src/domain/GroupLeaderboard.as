class GroupLeaderboard {
    string groupUid = "";
    string mapUid = "";
    array<LeaderboardZone@>@ tops = {};
    CampaignMap map;

    GroupLeaderboard() {}
    GroupLeaderboard(const string &in groupUid, const string &in mapUid) {
        this.groupUid = groupUid;
        this.mapUid = mapUid;
        if (mapUid != "") this.map = CampaignMap(mapUid);
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
