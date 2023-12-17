namespace State {
    Campaign CampaignData;
    GroupLeaderboard CampaignGLB;

    bool CampaignIsLoaded = false;

    void LoadCampaign() {
        CampaignData = Api::GetClubCampaign(S_Campaign_CampaignId);
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
            LoadCampaign();
            CampaignIsLoaded = true;
        } else {
            LogTrace("Updating Campaign State..");
            LoadLeaderboards();
            LogTrace("Updated Campaign State");
        }

    }
}
