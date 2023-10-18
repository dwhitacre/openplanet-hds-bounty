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
        trace(req.String());
        return Json::Parse(req.String());
    }

    string GetAccountId(const string &in playerName) {
        Json::Value accountInfo = Fetch(Audience::NadeoLiveServices, "api/token/club/" + Settings::Config.ClubId + "/member/" + playerName + "/from-login");
        if (accountInfo.Length <= 1) {
            throw("Failed to get accountId for player: " + playerName);
        }
        
        string accountId = accountInfo["accountId"];
        return accountId;
    }

    int GetPBTime(const string &in accountId, const string &in mapId) {
        Json::Value pbTimes = Fetch(Audience::NadeoServices, "mapRecords/?accountIdList=" + accountId + "&mapIdList=" + mapId);
        if (pbTimes.Length < 1 || pbTimes[0]["recordScore"] is null) {
            trace("Failed to get pbTime for accountId: " + accountId + "and mapId: " + mapId);
            return -1;
        }
        
        return pbTimes[0]["recordScore"]["time"];
    }

    string GetMapId(const string &in mapUid) {
        Json::Value mapInfo = Fetch(Audience::NadeoServices, "maps/?mapUidList=" + mapUid);
        if (mapInfo.Length < 1) {
            throw("Failed to get mapInfo for mapUid: " + mapUid);
        }
        
        string mapId = mapInfo[0]["mapId"];
        return mapId;
    }
}
