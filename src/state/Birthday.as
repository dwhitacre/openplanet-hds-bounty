namespace State {
    PlayerVM BirthdayGoalPlayer;
    PlayerVM BirthdayCurrentPlayer;
    PlayerVM BirthdayTopPlayer;
    array<PlayerVM@> BirthdayPlayers = {};

    bool BirthdayIsLoaded = false;

    void UpdateBirthdayTopPlayer() {
        // TODO
        BirthdayTopPlayer = PlayerVM(NadeoServices::GetAccountID()); // top on map account id        
    }

    void LoadBirthday(CTrackMania@ app) {
        BirthdayGoalPlayer = PlayerVM(S_Birthday_GoalPlayerAccountId);
        BirthdayPlayers.InsertLast(BirthdayGoalPlayer);
        
        BirthdayCurrentPlayer = PlayerVM(NadeoServices::GetAccountID());
        BirthdayPlayers.InsertLast(BirthdayCurrentPlayer);

        UpdateBirthdayTopPlayer();
        BirthdayPlayers.InsertLast(BirthdayTopPlayer);
    }

    void UpdateIsInBirthdayBountyMap() {
        if (BirthdayIsLoaded && S_Window_HideWhenNotInBountyMap) {
            auto app = cast<CTrackMania>(GetApp());
            auto map = app.RootMap;
            S_Window_IsInBountyMap = map !is null &&
                app.Editor is null &&
                map.MapInfo.MapUid != "" &&
                S_Birthday_MapUid == map.MapInfo.MapUid;
        }
    }

    void UpdateBirthdayState(CTrackMania@ app) {
        LogTrace("Updating Birthday State..");

        UpdateBirthdayTopPlayer();

        auto map = app.RootMap;
        TimeMgr::UpdateTimes(BirthdayPlayers, (!S_Birthday_LockMapUid && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) ? map.MapInfo.MapUid : S_Birthday_MapUid);

        LogTrace("Updated Birthday State");
    }

    void UpdateBirthday(CTrackMania@ app) {
        if (!BirthdayIsLoaded) {
            LoadBirthday(app);
            BirthdayIsLoaded = true;
        }
        
        UpdateBirthdayState(app);
    }
}
