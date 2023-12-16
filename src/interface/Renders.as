namespace Interface {
    void RenderStyledText(const string &in name, vec3 &in style = vec3(1, 1, 1)) {
        UI::Text(Text::FormatOpenplanetColor(style) + name);
    }

    void RenderTime(int time, vec3 &in style) {
        RenderStyledText((time > 0 ? Time::Format(time) : "-:--.---"), style);
    }

    void RenderAvgTime(int time, vec3 &in style) {
        RenderStyledText("(" + (time > 0 ? Time::Format(time) : "-:--.---") + ")", style);
    }
}