class UserModel {
  final String username;
  final String password;
  String? _sessionId = '';

  UserModel({
    required this.username,
    required this.password,
  });

  String get sessionId {
    return _sessionId!;
  }

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
  }
}
