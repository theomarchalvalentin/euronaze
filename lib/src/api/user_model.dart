class UserInfo {
  final String firstName;
  final String lastName;
  final String email;

  const UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
