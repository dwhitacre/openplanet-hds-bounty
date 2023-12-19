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
        bool isRb = S_Campaign_GroupHighlightRainbow;
        for (uint i = 0; i < rankings.Length; i++) {
            bool isYou = S_Campaign_GroupHighlight && rankings[i].accountId == S_Campaign_GroupHighlightYourAccountId;

            UI::TableNextRow();
            UI::TableNextColumn();
            RenderStyledText(Text::Format("%d", rankings[i].position), isYou ? (isRb ? S_Campaign_GroupHighlightRainbowColor : S_Campaign_GroupHighlightPositionColor) : S_Campaign_GroupPlayerPositionColor);
            UI::TableNextColumn();
            RenderStyledText(rankings[i].name, isYou ? (isRb ? S_Campaign_GroupHighlightRainbowColor : S_Campaign_GroupHighlightNameColor) : S_Campaign_GroupPlayerNameColor);
            if (S_Campaign_ShowGroupPlayerZone) {
                UI::TableNextColumn();
                RenderStyledText(rankings[i].zoneName, isYou ? (isRb ? S_Campaign_GroupHighlightRainbowColor : S_Campaign_GroupHighlightZoneColor) : S_Campaign_GroupPlayerZoneColor);
            }
            UI::TableNextColumn();
            RenderStyledText(rankings[i].sp, isYou ? (isRb ? S_Campaign_GroupHighlightRainbowColor : S_Campaign_GroupHighlightScoreColor) : S_Campaign_GroupPlayerScoreColor);

        }
        if (isRb) S_Campaign_GroupHighlightRainbowColor = Rainbow(S_Campaign_GroupHighlightRainbowColor);
    }

    void RenderGroupLeaderboard() {
        if (S_Campaign_ShowGroupLeaderboard)
        {
            if (S_Campaign_ShowGroupHeader) RenderStyledText("Campaign Leaderboard", S_Campaign_GroupHeaderColor);

            int numCols = S_Campaign_ShowGroupPlayerZone ? 4 : 3;
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