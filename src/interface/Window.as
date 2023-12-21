namespace Interface {
    void RenderWindow() {
        if (S_Window_HideWithIFace && !UI::IsGameUIVisible()) return;
        if (S_Window_HideWithOverlay && !UI::IsOverlayShown()) return;
        if (S_Window_HideWhenNotInBountyMap && !S_Window_IsInBountyMap) {
            State::UpdateIsInBountyMap();
            return;
        }
        if (!S_Window_Visible) return;

        if (S_Window_LockPosition) UI::SetNextWindowPos(int(S_Window_Anchor.x), int(S_Window_Anchor.y), UI::Cond::Always);
        else UI::SetNextWindowPos(int(S_Window_Anchor.x), int(S_Window_Anchor.y), UI::Cond::FirstUseEver);

        int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;
        if (!UI::IsOverlayShown()) windowFlags |= UI::WindowFlags::NoInputs;

        S_Campaign_GroupHighlightRainbowColor = Rainbow(S_Campaign_GroupHighlightRainbowColor);

        if (S_Window_Rainbow) UI::PushStyleColor(UI::Col::WindowBg, vec4(S_Campaign_GroupHighlightRainbowColor, 1));
        else UI::PushStyleColor(UI::Col::WindowBg, vec4(.1, .1, .1, 1));
        UI::PushStyleVar(UI::StyleVar::WindowPadding, vec2(10, 10));
        UI::PushStyleVar(UI::StyleVar::WindowRounding, 10.0);
        UI::PushStyleVar(UI::StyleVar::FramePadding, vec2(10, 6));
        if (UI::Begin(State::PluginDisplayNameAndVersion, S_Window_Visible, windowFlags)) {
            if (!S_Window_LockPosition) S_Window_Anchor = UI::GetWindowPos();
            if (S_TTA_UseMode) RenderTTA();
            else RenderCampaign();
            UI::End();
        }
        UI::PopStyleVar(3);
        UI::PopStyleColor(1);
    }
}