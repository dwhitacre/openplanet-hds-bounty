namespace AccountMgr {
    dictionary accountIdCache = {};

    string GetAccountId(const string &in playerName) {
        string accountId = "";
        if (accountIdCache.Exists(playerName)) accountIdCache.Get(playerName, accountId);
        if (accountId.Length <= 0) {
            accountId = Api::GetAccountId(playerName);
            accountIdCache.Set(playerName, accountId);
        }
        return accountId;
    }

    void Clear() {
        accountIdCache.DeleteAll();
    }

    void Debug() {
        print(accountIdCache.ToJson());
    }

    void Init(const array<string> &in playerNames) {
        auto accountIds = Api::GetAccountIds(playerNames);
        for (uint i = 0; i < accountIds.Length; i++) {
            accountIdCache.Set(playerNames[i], accountIds[i]);
        }
    }
}