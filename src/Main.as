void Main() {
    auto app = cast<CTrackMania>(GetApp());
    Api::Init();

    while (true) {
        if (S_Advanced_StateUpdateEnabled) {
            if (S_TTA_UseMode) State::UpdateTTA(app);
            else State::UpdateCampaign(app);
        } else LogTrace("Skipped State Update.");
        sleep(S_Advanced_StateUpdateDelay);
    }
}

void OnDestroyed() { _Unload(); }
void OnDisabled() { _Unload(); }
void _Unload() {
}

void OnKeyPress(bool down, VirtualKey key) {
    if (down && key == S_Window_VisibleKey) S_Window_Visible = !S_Window_Visible;
}

void RenderMenu() {
    if (UI::MenuItem(State::PluginDisplayName, "", S_Window_Visible)) {
        S_Window_Visible = !S_Window_Visible;
    }
}

void Render() {
    Interface::RenderWindow();
}
