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
}