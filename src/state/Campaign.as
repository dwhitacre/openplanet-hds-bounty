namespace State {
    Campaign CampaignData;
    GroupLeaderboard CampaignGLB;
    array<GroupLeaderboard@> CampaignMLBs;

    bool CampaignIsLoaded = false;

    void LoadCampaign(CTrackMania@ app) {
        CampaignData = Api::GetClubCampaign(S_Campaign_CampaignId);
        S_Campaign_HighlightYourAccountId = NadeoServices::GetAccountID();
        LoadLeaderboards();
        LoadMapLeaderboards();
    }

    void LoadLeaderboards() {
        CampaignGLB = Api::GetGroupLeaderboard(CampaignData.leaderboardGroupUid);
    }

    void LoadMapLeaderboards() {
        for (uint i = 0; i < CampaignData.playlist.Length; i++) {
            CampaignMLBs.InsertLast(Api::GetMapLeaderboard(CampaignData.leaderboardGroupUid, CampaignData.playlist[i].uid));
        }
    }

    void UpdateMapLeaderboards() {
        for (uint i = 0; i < CampaignMLBs.Length; i++) {
            CampaignMLBs[i] = Api::GetMapLeaderboard(CampaignData.leaderboardGroupUid, CampaignMLBs[i].mapUid);
        }
    }

    void UpdateCampaign(CTrackMania@ app) {
        if (!CampaignIsLoaded) {
            LoadCampaign(app);
            CampaignIsLoaded = true;
        } else {
            LogTrace("Updating Campaign State..");
            LoadLeaderboards();
            UpdateMapLeaderboards();
            LogTrace("Updated Campaign State");
        }
    }
}
