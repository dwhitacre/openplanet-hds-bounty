namespace MapMgr {
    class MapCache : Cache {
        string call(const string &in key) override {
            LogTrace("Getting map id for uid: " + key);
            return Api::GetMapId(key);
        }
    }

    MapCache cache = MapCache();

    string GetMapId(const string &in mapUid) {
        return cache.Get(mapUid);
    }
}