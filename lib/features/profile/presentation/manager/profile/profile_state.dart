import 'package:flutter/material.dart';

import '../../../../auth/domain/entities/auth_entity.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final AuthEntity authEntity;

  ProfileSuccess(this.authEntity);
}

class ProfileFailure extends ProfileState {
  final String errMessage;

  ProfileFailure(this.errMessage);
}
