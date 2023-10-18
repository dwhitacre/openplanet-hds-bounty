namespace MapMgr {
    class MapCache : Cache {
        string call(const string &in key) override {
            return Api::GetMapId(key);
        }
    }

    MapCache cache = MapCache();

    string GetMapId(const string &in mapUid) {
        return cache.Get(mapUid);
    }
}