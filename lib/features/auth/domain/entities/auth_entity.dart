class AuthEntity {
  final String id; // Unique ID for the user
  final String email;
  final String username;
  final String? photoUrl;
  final String? phoneNumber;
  final String? birthday;

  AuthEntity({
    required this.id,
    required this.email,
    required this.username,
    this.photoUrl,
    this.phoneNumber,
    this.birthday,
  });
}
