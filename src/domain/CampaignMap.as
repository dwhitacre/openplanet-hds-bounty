class CampaignMap {
    int id = -1;
    int position = -1;
    string uid = "";
    string name;
    string author;

    CampaignMap() {}
    CampaignMap(int id, int position, const string &in uid) {
        this.id = id;
        this.position = position;
        this.uid = uid;
    }
    CampaignMap(const string &in uid) {
        this.uid = uid;

        auto mapInfo = Api::GetMapInfo(this.uid);
        this.name = mapInfo["name"];
        this.author = AccountMgr::GetDisplayName(mapInfo["author"]);
    }

    int opCmp(CampaignMap@ other) {
        return this.position - other.position;
    }

    string ToString() {
        return KeyValuesToString({
            {"id", Text::Format("%d", this.id)},
            {"position", Text::Format("%d", this.position)},
            {"uid", this.uid},
            {"name", this.name},
            {"author", this.author}
        });
    }
}
