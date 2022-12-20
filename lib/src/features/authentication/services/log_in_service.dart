import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:zoo_flutter/src/features/authentication/configs/auth_configs.dart';
import 'package:zoo_flutter/src/features/authentication/model/log_in_status.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:http/http.dart' as http;

class LogInService implements ILogInService {
  final logInUrl = "http://localhost:3000/api/login";
  final bearerPrefix = "Bearer ";
  final secureStorage = const FlutterSecureStorage();

  const LogInService();

  @override
  Future<http.Response> logIn(logInReq) async {
    final resp = await http.post(Uri.parse(logInUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(logInReq));

    if (resp.statusCode != 200) {
      return resp;
    }

    final bearer = resp.headers["authorization"];
    final refresh = jsonDecode(resp.body)[AuthConfig.refreshToken.storeKey];

    if (bearer != null && refresh != null) {
      await storeTokens(bearer, refresh);
    }

    return resp;
  }

  @override
  Future<LogInStatus> getLogInStatus() async {
    final bearerExp = await getBearerTokenExp();

    final bearerExpDate = DateTime.tryParse(bearerExp ?? "");

    if (bearerExpDate == null) {
      return LogInStatus.logOut;
    }
    if (bearerExpDate.compareTo(DateTime.now()) > 0) {
      return LogInStatus.logIn;
    }
    return await canRefresh() ? LogInStatus.needRefresh : LogInStatus.logOut;
  }

  storeTokens(String bearer, String refresh) async {
    final DateTime bearerTokenExp = JwtDecoder.getExpirationDate(
        bearer.replaceFirst(AuthConfig.bearerToken.prefix, ""));
    final DateTime refreshTokenExp = JwtDecoder.getExpirationDate(refresh);

    await setBearerToken(bearer);
    await setBearerTokenExp(bearerTokenExp);
    await setRefreshToken(refresh);
    await setRefreshTokenExp(refreshTokenExp);
  }

  canRefresh() async {
    final refreshExp = DateTime.tryParse(await getRefreshTokenExp());
    if (refreshExp == null) {
      return false;
    }
    final maxDate = DateTime.now().subtract(
        Duration(seconds: AuthConfig.refreshToken.expMarginInSeconds));

    return (refreshExp.compareTo(maxDate) > 0);
  }

  @override
  getBearerToken() async {
    return secureStorage.read(key: AuthConfig.bearerToken.storeKey);
  }

  @override
  getBearerTokenExp() async {
    return secureStorage.read(key: AuthConfig.bearerToken.expStoreKey);
  }

  setBearerToken(String value) async {
    return secureStorage.write(
        key: AuthConfig.bearerToken.storeKey, value: value);
  }

  setBearerTokenExp(DateTime value) async {
    return secureStorage.write(
        key: AuthConfig.bearerToken.expStoreKey, value: value.toString());
  }

  @override
  getRefreshToken() async {
    return secureStorage.read(key: AuthConfig.bearerToken.storeKey);
  }

  getRefreshTokenExp() async {
    return secureStorage.read(key: AuthConfig.bearerToken.expStoreKey);
  }

  setRefreshToken(String value) async {
    return secureStorage.write(
        key: AuthConfig.refreshToken.storeKey, value: value);
  }

  setRefreshTokenExp(DateTime value) async {
    return secureStorage.write(
        key: AuthConfig.bearerToken.expStoreKey, value: value.toString());
  }
}
