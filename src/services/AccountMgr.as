namespace AccountMgr {
    class AccountCache : Cache {
        string call(const string &in key) override {
            return Api::GetAccountId(key);
        }

        array<string> callMany(const array<string> &in keys) override {
            return Api::GetAccountIds(keys);
        }
    }

    AccountCache cache = AccountCache();

    string GetAccountId(const string &in playerName) {
        return cache.Get(playerName);
    }

    void Init(const array<string> &in playerNames) {
        cache.Init(playerNames);
    }
}