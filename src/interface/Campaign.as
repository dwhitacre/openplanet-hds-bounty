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

    void RenderLeaderboardRankings(array<LeaderboardRanking@>@ rankings, vec3 positionColor, vec3 nameColor, vec3 scoreColor, bool shouldHighlight, vec3 hPositionColor, vec3 hNameColor, vec3 hScoreColor) {
        for (uint i = 0; i < rankings.Length; i++) {
            bool isYou = shouldHighlight && rankings[i].accountId == S_Campaign_HighlightYourAccountId;
            UI::TableNextRow();
            UI::TableNextColumn();
            RenderStyledText(Text::Format("%d", rankings[i].position), isYou ? hPositionColor : positionColor);
            UI::TableNextColumn();
            RenderStyledText(rankings[i].name, isYou ? hNameColor : nameColor);
            UI::TableNextColumn();
            RenderStyledText(rankings[i].sp, isYou ? hScoreColor : scoreColor);
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
                        RenderLeaderboardRankings(
                            State::CampaignGLB.tops[i].rankings,
                            S_Campaign_GroupPlayerPositionColor,
                            S_Campaign_GroupPlayerNameColor,
                            S_Campaign_GroupPlayerScoreColor,
                            S_Campaign_GroupHighlight,
                            S_Campaign_GroupHighlightPositionColor,
                            S_Campaign_GroupHighlightNameColor,
                            S_Campaign_GroupHighlightScoreColor
                        );
                        UI::TableNextRow();
                    }
                }
                UI::TableNextRow();
                UI::EndTable();
            }
        }
    }

    void RenderMapLeaderboards() {
        if (S_Campaign_ShowMapsLeaderboards)
        {
            if (S_Campaign_ShowMapsHeader) RenderStyledText("Map Leaderboards", S_Campaign_MapsHeaderColor);

            int numCols = 3;
            if (UI::BeginTable("Campaign_MLBs_Table", numCols, UI::TableFlags::SizingFixedFit)) {
                for (uint i = 0; i < State::CampaignMLBs.Length; i++) {
                    for (uint j = 0; j < State::CampaignMLBs[i].tops.Length; j++) {
                        if (State::CampaignMLBs[i].tops[j].zoneName == S_Campaign_ZoneName) {
                            UI::TableNextRow();
                            RenderLeaderboardRankings(
                                State::CampaignMLBs[i].tops[j].rankings,
                                S_Campaign_MapPlayerPositionColor,
                                S_Campaign_MapPlayerNameColor,
                                S_Campaign_MapPlayerScoreColor,
                                S_Campaign_MapHighlight,
                                S_Campaign_MapHighlightPositionColor,
                                S_Campaign_MapHighlightNameColor,
                                S_Campaign_MapHighlightScoreColor
                            );
                            UI::TableNextRow();
                        }
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
            RenderMapLeaderboards();
        } else {
            RenderStyledText("Loading Campaign... Please wait..");
        }
    }
}