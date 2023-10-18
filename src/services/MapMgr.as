namespace MapMgr {
    dictionary mapIdCache = {};

    string GetMapId(const string &in mapUid) {
        string mapId = "";
        if (mapIdCache.Exists(mapUid)) mapIdCache.Get(mapUid, mapId);
        if (mapId.Length <= 0) {
            mapId = Api::GetMapId(mapUid);
            mapIdCache.Set(mapUid, mapId);
        }
        return mapId;
    }

    void Clear() {
        mapIdCache.DeleteAll();
    }

    void Debug() {
        print(mapIdCache.ToJson());
    }
}