import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_entity.dart';

class AuthModel {
  final String? id;
  final String? email;
  final String? username;
  final String? photoUrl;
  final String? phoneNumber;
  final String? birthday;

  AuthModel({
    this.id,
    this.email,
    this.username,
    this.photoUrl,
    this.phoneNumber,
    this.birthday,
  });

  /// Create AuthModel from Firebase User
  factory AuthModel.fromFirebaseUser(User user) => AuthModel(
        id: user.uid,
        email: user.email,
        username: user.displayName,
        photoUrl: user.photoURL,
        phoneNumber: user.phoneNumber,
        birthday: null, // Firebase User doesn't have birth date
      );

  /// Create AuthModel from a generic map
  factory AuthModel.fromMap(Map<String, dynamic> map) => AuthModel(
        id: map['id'] as String?,
        email: map['email'] as String?,
        username: map['username'] as String?,
        photoUrl: map['photoUrl'] as String?,
        phoneNumber: map['phoneNumber'] as String?,
        birthday: map['birthday'] as String?,
      );

  /// Convert AuthModel to a generic map
  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'username': username,
        'photoUrl': photoUrl,
        'phoneNumber': phoneNumber,
        'birthday': birthday,
      };

  /// Create AuthModel from AuthEntity
  factory AuthModel.fromEntity(AuthEntity entity) => AuthModel(
        id: entity.id,
        email: entity.email,
        username: entity.username,
        photoUrl: entity.photoUrl,
        phoneNumber: entity.phoneNumber,
        birthday: entity.birthday,
      );

  /// Convert AuthModel to AuthEntity
  AuthEntity toEntity() => AuthEntity(
        id: id ?? '',
        email: email ?? '',
        username: username ?? '',
        photoUrl: photoUrl ?? '',
        phoneNumber: phoneNumber ?? '',
        birthday: birthday ?? '',
      );
}
