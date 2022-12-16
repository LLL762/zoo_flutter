class LoginRequest {
  String? username;
  String? password;

  LoginRequest(this.username, this.password);
}

enum LogInStatus { logIn, logOut, needRefresh }
