namespace Interface {
    int64 getTimeLeft() {
        return (S_Birthday_CountdownStartTime - Time::get_Stamp()) * 1000;
    }

    bool shouldRenderCountdown() {
        return S_Birthday_ShowCountdown && getTimeLeft() >= 0;
    }

    void RenderBirthdayBountyName() {
        if (S_Birthday_ShowBountyName)
        {
            UI::BeginTable("Birthday_BountyName", 1, UI::TableFlags::SizingFixedFit);
            UI::TableNextRow();
            UI::TableNextColumn();
            RenderStyledText(Icons::BirthdayCake + " " + S_Birthday_BountyName, S_Birthday_BountyNameRainbow ? S_Birthday_RainbowColor : S_Birthday_BountyNameColor);
            UI::EndTable();
        }
    }

    void RenderCountdown() {
        if (State::BigFont is null) return;
        UI::PushFont(State::BigFont);
        RenderStyledText(Time::Format(getTimeLeft(), false, true, true), S_Birthday_CountdownRainbow ? S_Birthday_RainbowColor : S_Birthday_CountdownColor);
        UI::PopFont();
    }

    void RenderBirthdayMode() {
        RenderStyledText("Bounty Started! Update your plugin.", S_Birthday_CountdownRainbow ? S_Birthday_RainbowColor : S_Birthday_CountdownColor);
    }

    void RenderDiscordButton() {
        if (UI::Button(Icons::DiscordAlt + " Bounty Discord")) OpenBrowserURL(S_Birthday_DiscordLink);
    }

    void RenderBirthday() {
        RenderBirthdayBountyName();
        if (shouldRenderCountdown()) RenderCountdown();
        else RenderBirthdayMode();
        RenderDiscordButton();
        if (S_Birthday_BountyNameRainbow || S_Birthday_CountdownRainbow) S_Birthday_RainbowColor = Rainbow(S_Birthday_RainbowColor, S_Birthday_RainbowInterval);
    }
}