namespace Interface {
    void RenderCampaignBountyName() {
        if (S_Campaign_ShowBountyName)
        {
            UI::BeginTable("Campaign_BountyName", 1, UI::TableFlags::SizingFixedFit);
            UI::TableNextRow();
            UI::TableNextColumn();
            RenderStyledText(State::PluginDisplayName, S_TTA_BountyNameColor);
            UI::EndTable();
        }
    }

    void RenderLeaderboardRankings(array<LeaderboardRanking@>@ rankings) {
        for (uint i = 0; i < rankings.Length; i++) {
            UI::TableNextRow();
            UI::TableNextColumn();
            RenderStyledText(Text::Format("%d", rankings[i].position));
            UI::TableNextColumn();
            RenderStyledText(AccountMgr::GetDisplayName(rankings[i].accountId));
            UI::TableNextColumn();
            RenderStyledText(rankings[i].sp);
        }
    }

    void RenderGroupLeaderboard() {
        if (S_Campaign_ShowGroupLeaderboard)
        {
            if (S_Campaign_ShowGroupHeader) RenderStyledText("Campaign Leaderboard", S_Campaign_GroupHeaderColor);

            int numCols = 3;
            if (UI::BeginTable("Campaign_GLB_Table", numCols, UI::TableFlags::SizingFixedFit)) {
                for (uint i = 0; i < State::CampaignGLB.tops.Length; i++) {
                    if (State::CampaignGLB.tops[i].zoneName == S_Campaign_ZoneName) {
                        UI::TableNextRow();
                        RenderLeaderboardRankings(State::CampaignGLB.tops[i].rankings);
                        UI::TableNextRow();
                    }
                }
                UI::EndTable();
            }
        }
    }

    void RenderCampaign() {
        RenderCampaignBountyName();

        if (State::CampaignIsLoaded) {
            RenderGroupLeaderboard();
        } else {
            RenderStyledText("Loading Campaign... Please wait..");
        }
    }
}