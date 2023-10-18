class Cache {
    Cache() {}
    dictionary c = {};
    
    string call(const string &in key) {
        throw('Cache implementations need to override call');
        return "";
    }

    array<string> callMany(const array<string> &in keys) {
        throw('Cache implementations need to override callMany');
        return {};
    }
    
    string Get(const string &in key) {
        string value = "";
        if (c.Exists(key)) c.Get(key, value);
        if (value.Length <= 0) {
            value = call(key);
            c.Set(key, value);
        }
        return value;
    }

    void Init(const array<string> &in keys) {
        array<string> values = callMany(keys);
        if (values.Length != keys.Length) throw('Cache implementations callMany needs to return same amount of values as keys');

        for (uint i = 0; i < values.Length; i++) {
            c.Set(keys[i], values[i]);
        }
    }

    void Clear() {
        c.DeleteAll();
    }

    void Debug() {
        print(c.ToJson());
    }
}