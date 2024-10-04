class LoginModel {
  final String username;
  final String password;

  LoginModel({required this.username, required this.password});

  String? validateCredentials() {
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    if ((password.isEmpty) || (password.length < 6)) {
      return 'Password cannot be empty or Password must be at least 6 characters long';
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(username: json['username'], password: 'password');
  }
}
