class UserModel {
  final String userEmail;
  final String userPassword;
  final String userId;
  final String userRole;
  final String userName;

  UserModel({
    required this.userEmail,
    required this.userPassword,
    required this.userId,
    required this.userRole,
    required this.userName,
  });

  Map<String, dynamic> toJson() => {
        "userEmail": userEmail,
        "userPassword": userPassword,
        "userId": userId,
        "userRole": userRole,
        "userName": userName,
      };
}
