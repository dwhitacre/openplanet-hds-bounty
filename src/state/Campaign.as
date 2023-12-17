namespace State {
    Campaign CampaignData;
    GroupLeaderboard CampaignGLB;

    bool CampaignIsLoaded = false;

    void LoadCampaign(CTrackMania@ app) {
        CampaignData = Api::GetClubCampaign(S_Campaign_CampaignId);
        S_Campaign_GroupHighlightYourAccountId = "c7818ba0-5e85-408e-a852-f658e8b90eec"; // NadeoServices::GetAccountID();
        LoadLeaderboards();
    }

    void LoadLeaderboards() {
        CampaignGLB = Api::GetGroupLeaderboard(CampaignData.leaderboardGroupUid);
        // for (uint i = 0; i < CampaignData.playlist.Length; i++) {
        //     Api::GetMapLeaderboard(CampaignData.leaderboardGroupUid, CampaignData.playlist[i].uid);
        // }
    }

    void UpdateCampaign(CTrackMania@ app) {
        if (!CampaignIsLoaded) {
            LoadCampaign(app);
            CampaignIsLoaded = true;
        } else {
            LogTrace("Updating Campaign State..");
            LoadLeaderboards();
            LogTrace("Updated Campaign State");
        }

    }
}
