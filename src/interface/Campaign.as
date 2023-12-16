namespace Interface {
    void RenderCampaign() {
        RenderStyledText("Coming soon..");

        // UI::BeginTabBar("SettingCategories", UI::TabBarFlags::TabListPopupButton);
        // for (uint i = 0; i < State::SettingCategories.Length; i++) {
        //     auto category = State::SettingCategories[i];
        //     UI::PushID(category);

        //     vec4 color = vec4(0.2f, 0.4f, 0.8f, 1);
        //     UI::PushStyleColor(UI::Col::Tab, color * vec4(0.5f, 0.5f, 0.5f, 0.75f));
        //     UI::PushStyleColor(UI::Col::TabHovered, color * vec4(1.2f, 1.2f, 1.2f, 0.85f));
        //     UI::PushStyleColor(UI::Col::TabActive, color);

        //     if (UI::BeginTabItem(category.GetName())) {
        //         Render(category);
        //         UI::EndTabItem();
        //     }

        //     UI::PopStyleColor(3);
        //     UI::PopID();
        // }

        // UI::EndTabBar();
    }
}