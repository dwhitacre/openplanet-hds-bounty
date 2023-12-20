namespace State {
    Campaign CampaignData;
    GroupLeaderboard CampaignGLB;
    GroupLeaderboard CampaignYLB;

    bool CampaignIsLoaded = false;

    void LoadCampaign(CTrackMania@ app) {
        CampaignData = Api::GetClubCampaign(S_Campaign_CampaignId);
        // S_Campaign_GroupHighlightYourAccountId = "11000022-b227-4c42-95ab-c2f8559d894c";
        S_Campaign_GroupHighlightYourAccountId = NadeoServices::GetAccountID();
        LoadLeaderboards();
    }

    void LoadLeaderboards() {
        CampaignGLB = Api::GetGroupLeaderboard(CampaignData.leaderboardGroupUid);
        CampaignYLB = Api::GetYourLeaderboard(CampaignData.leaderboardGroupUid, S_Campaign_GroupHighlightYourAccountId);
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
