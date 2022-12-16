class AuthConfig {
  static const get = {
    "bearerToken": {
      "prefix": "Bearer ",
      "storeKey": "bearerToken",
      "expStoreKey": "bearerTokenExp"
    },
    "refreshToken": {
      "respBodyKey": "refreshToken",
      "storeKey": "refreshToken",
      "expStoreKey": "refreshTokenExp"
    }
  };
}
