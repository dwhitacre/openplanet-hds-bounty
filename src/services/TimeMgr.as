namespace TimeMgr {
    int GetPBTime(const string &in accountId, const string &in mapUid) {
        string mapId = MapMgr::GetMapId(mapUid);
        return Api::GetPBTime(accountId, mapId);
    }

    array<int> GetPBTimes(const array<string> &in accountIds, const string &in mapUid) {
        string mapId = MapMgr::GetMapId(mapUid);
        return Api::GetPBTimes(accountIds, mapId);
    }

    int CompareTimes(const int &in timeA, const int &in timeB) {
        if ((timeA >= 0) == (timeB >= 0)) {
            int64 diff = int64(timeA) - int64(timeB);
            return diff == 0 ? 0 : diff > 0 ? 1 : -1;
        } else {
            int64 diff = int64(timeB) - int64(timeA);
            return diff == 0 ? 0 : diff > 0 ? 1 : -1;
        }
    }

    void UpdateTimes(const string &in mapUid) {
        array<string> accountIds = {};
        for (uint i = 0; i < Display::Players.Length; i++) {
            accountIds.InsertLast(Display::Players[i].accountId);
        }

        array<int> times = GetPBTimes(accountIds, mapUid);
        for (uint i = 0; i < Display::Players.Length; i++) {
            Display::Players[i].time = times[i];
        }
    }
}