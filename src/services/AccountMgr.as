namespace AccountMgr {
    class AccountCache : Cache {
        string call(const string &in key) override {
            LogTrace("Getting account id for player: " + key);
            return Api::GetAccountId(key);
        }

        array<string> callMany(array<string>@ keys) override {
            LogTrace("Getting account id for players:\n" + ArrayToString(keys));
            return Api::GetAccountIds(keys);
        }
    }

    AccountCache cache = AccountCache();

    string GetAccountId(const string &in playerName) {
        return cache.Get(playerName);
    }

    void Init(array<string>@ playerNames) {
        cache.Init(playerNames);
    }
}