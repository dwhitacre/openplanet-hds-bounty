namespace Api {
    enum Audience {
        NadeoClubServices,
        NadeoLiveServices,
        NadeoServices
    }

    string getAudienceName(const Audience &in aud) {
        switch (aud) {
            case Audience::NadeoClubServices:
                return "NadeoClubServices";
            case Audience::NadeoLiveServices:
                return "NadeoLiveServices";
            case Audience::NadeoServices:
            default:
                return "NadeoServices";
        }
    }

    string getUrl(const Audience &in aud) {
        switch (aud) {
            case Audience::NadeoClubServices:
                return NadeoServices::BaseURLClub();
            case Audience::NadeoLiveServices:
                return NadeoServices::BaseURLLive();
            case Audience::NadeoServices:
            default:
                return NadeoServices::BaseURLCore();
        }
    }

    void Init() {
        NadeoServices::AddAudience(getAudienceName(Audience::NadeoClubServices));
        NadeoServices::AddAudience(getAudienceName(Audience::NadeoLiveServices));
        NadeoServices::AddAudience(getAudienceName(Audience::NadeoServices));

        while (!NadeoServices::IsAuthenticated(getAudienceName(Audience::NadeoClubServices)) &&
            !NadeoServices::IsAuthenticated(getAudienceName(Audience::NadeoLiveServices)) &&
            !NadeoServices::IsAuthenticated(getAudienceName(Audience::NadeoServices))) 
        {
            yield();
        }
    }

    Json::Value Fetch(const Audience &in aud, const string &in route) {
        auto req = NadeoServices::Get(getAudienceName(aud), getUrl(aud) + "/" + route);
        req.Start();
        while (!req.Finished()) {
            yield();
        }
        return Json::Parse(req.String());
    }

    array<Json::Value> FetchMany(const Audience &in aud, array<string>@ routes) {
        array<Net::HttpRequest@> reqs = {};
        for (uint i = 0; i < routes.Length; i++) {
            auto req = NadeoServices::Get(getAudienceName(aud), getUrl(aud) + "/" + routes[i]);
            req.Start();
            reqs.InsertLast(req);
        }

        array<Json::Value> values = {};
        for (uint i = 0; i < reqs.Length; i++) {
            while (!reqs[i].Finished()) {
                yield();
            }
            values.InsertLast(Json::Parse(reqs[i].String()));
        }

        return values;
    }

    string GetAccountId(const string &in playerName) {
        Json::Value accountInfo = Fetch(Audience::NadeoLiveServices, "api/token/club/" + S_Advanced_ClubId + "/member/" + playerName + "/from-login");
        if (accountInfo.Length <= 1) {
            throw("Failed to get accountId for player: " + playerName);
        }
        return accountInfo["accountId"];
    }

    array<string> GetAccountIds(array<string>@ playerNames) {
        array<string> routes = {};
        for (uint i = 0; i < playerNames.Length; i++) {
            routes.InsertLast("api/token/club/" + S_Advanced_ClubId + "/member/" + playerNames[i] + "/from-login");
        }

        array<Json::Value> accountInfos = FetchMany(Audience::NadeoLiveServices, routes);
        array<string> accountIds = {};
        for (uint i = 0; i < accountInfos.Length; i++) {
            if (accountInfos[i].Length <= 1) {
                throw("Failed to get accountId for player: " + playerNames[i]);
            }

            accountIds.InsertLast(accountInfos[i]["accountId"]);
        }

        return accountIds;
    }

    int GetPBTime(const string &in accountId, const string &in mapId) {
        Json::Value pbTimes = Fetch(Audience::NadeoServices, "mapRecords/?accountIdList=" + accountId + "&mapIdList=" + mapId);
        if (pbTimes.Length < 1 || pbTimes[0]["recordScore"] is null) {
            trace("Failed to get pbTime for accountId: " + accountId + "and mapId: " + mapId);
            return -1;
        }
        
        return pbTimes[0]["recordScore"]["time"];
    }

    array<int> GetPBTimes(array<string>@ accountIds, const string &in mapId) {
        Json::Value pbTimes = Fetch(Audience::NadeoServices, "mapRecords/?accountIdList=" + string::Join(accountIds, ",") + "&mapIdList=" + mapId);
        if (pbTimes.Length < 1) {
            throw("Failed to get pbTime for mapId: " + mapId);
        }

        array<int> times = {};
        times.Resize(accountIds.Length);

        for (uint i = 0; i < pbTimes.Length; i++) {
            string accountId = pbTimes[i]["accountId"];
            int accountIdIdx = accountIds.Find(accountId);

            int time = -1;
            if (accountIdIdx >= 0 && pbTimes[i]["recordScore"] !is null) time = pbTimes[i]["recordScore"]["time"];
            times[accountIdIdx] = time;
        }
        
        return times;
    }

    string GetMapId(const string &in mapUid) {
        Json::Value mapInfo = Fetch(Audience::NadeoServices, "maps/?mapUidList=" + mapUid);
        if (mapInfo.Length < 1) {
            throw("Failed to get mapInfo for mapUid: " + mapUid);
        }
        return mapInfo[0]["mapId"];
    }
}
