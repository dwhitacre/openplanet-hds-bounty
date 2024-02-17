namespace State {
    bool BirthdayIsLoaded = false;

    void LoadBirthday(CTrackMania@ app) {
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

    void UpdateBirthday(CTrackMania@ app) {
        if (!BirthdayIsLoaded) {
            LoadBirthday(app);
            BirthdayIsLoaded = true;
        } else {
            LogTrace("Updating Birthday State..");

            LogTrace("Updated Birthday State");
        }

    }
}
