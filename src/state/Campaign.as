namespace State {
    Campaign CampaignData;
    GroupLeaderboard CampaignGLB;

    bool CampaignIsLoaded = false;

    void LoadCampaign(CTrackMania@ app) {
        CampaignData = Api::GetClubCampaign(S_Campaign_CampaignId);
        S_Campaign_GroupHighlightYourAccountId = NadeoServices::GetAccountID();
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
