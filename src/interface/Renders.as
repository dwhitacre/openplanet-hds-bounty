namespace Interface {
    void RenderStyledText(const string &in name, vec3 style = vec3(1, 1, 1)) {
        UI::Text(Text::FormatOpenplanetColor(style) + name);
    }

    void RenderTime(int time, vec3 style) {
        RenderStyledText((time > 0 ? Time::Format(time) : "-:--.---"), style);
    }

    void RenderAvgTime(int time, vec3 style) {
        RenderStyledText("(" + (time > 0 ? Time::Format(time) : "-:--.---") + ")", style);
    }

    vec3 Rainbow(vec3 rainbow) {
        if (rainbow.x >= 1.f && rainbow.y < 1.f && rainbow.z <= 0.f) return vec3(1.f, incrementRainbow(rainbow.y), 0.f);
        else if (rainbow.x > 0.f && rainbow.y >= 1.f && rainbow.z <= 0.f) return vec3(decrementRainbow(rainbow.x), 1.f, 0.f);
        else if (rainbow.x <= 0.f && rainbow.y >= 1.f && rainbow.z < 1.f) return vec3(0.f, 1.f, incrementRainbow(rainbow.z));
        else if (rainbow.x <= 0.f && rainbow.y > 0.f && rainbow.z >= 1.f) return vec3(0.f, decrementRainbow(rainbow.y), 1.f);
        else if (rainbow.x < 1.f && rainbow.y <= 0.f && rainbow.z >= 1.f) return vec3(incrementRainbow(rainbow.x), 0.f, 1.f);
        else if (rainbow.x >= 1.f && rainbow.y <= 0.f && rainbow.z > 0.f) return vec3(1.f, 0.f, decrementRainbow(rainbow.z));
        else return vec3(1.f, 0.f, 0.f);
    }

    float incrementRainbow(float value) {
        return value + S_Campaign_GroupHighlightRainbowInterval;
    }

    float decrementRainbow(float value) {
        return value - S_Campaign_GroupHighlightRainbowInterval;
    }
}