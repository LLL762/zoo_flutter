class AuthConfig {
  static const bearerToken = BearerToken();
  static const refreshToken = RefreshToken();
}

class BearerToken {
  final prefix = "Bearer ";
  final storeKey = "bearerToken";
  final expStoreKey = "bearerTokenExp";

  const BearerToken();
}

class RefreshToken {
  final respBodyKey = "refreshToken";
  final storeKey = "refreshToken";
  final expStoreKey = "refreshTokenExp";
  final expMarginInSeconds = 2;

  const RefreshToken();
}
