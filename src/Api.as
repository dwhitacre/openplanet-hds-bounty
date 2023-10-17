namespace Api {
    enum Audience {
        NadeoClubServices,
        NadeoLiveServices
    }

    string getAudienceName(const Audience &in aud) {
        switch (aud) {
            case Audience::NadeoClubServices:
                return "NadeoClubServices";
            case Audience::NadeoLiveServices:
                return "NadeoLiveServices";
            default:
                return "UNKNOWN";
        }
    }

    string getUrl(const Audience &in aud) {
        switch (aud) {
            case Audience::NadeoClubServices:
                return NadeoServices::BaseURLClub();
            case Audience::NadeoLiveServices:
                return NadeoServices::BaseURLLive();
            default:
                return NadeoServices::BaseURL();
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
        Json::Value accountInfo = Fetch(Audience::NadeoLiveServices, "api/token/club/" + Settings_Config_ClubId + "/member/" + playerName + "/from-login");
        if (accountInfo.Length <= 1) {
            throw("Failed to get accountId for player: " + playerName);
        }
        
        string accountId = accountInfo["accountId"];
        return accountId;
    }
}
