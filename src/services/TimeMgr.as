namespace TimeMgr {
    dictionary timeCache = {};

    int GetPBTime(const string &in accountId, const string &in mapUid) {
        int time = -1;
        if (timeCache.Exists(accountId)) timeCache.Get(accountId, time);
        if (time < 0) {
            auto mapId = MapMgr::GetMapId(mapUid);
            time = Api::GetPBTime(accountId, mapId);
            timeCache.Set(accountId, time);
        }
        return time;
    }

    void Clear() {
        timeCache.DeleteAll();
    }

    void Debug() {
        print(timeCache.ToJson());
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
}