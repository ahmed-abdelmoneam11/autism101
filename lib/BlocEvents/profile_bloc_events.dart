import 'dart:io';
import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileStartEvent extends ProfileEvent {}

class GetProfileDataEvent extends ProfileEvent {}

class UpdateUserName extends ProfileEvent {
  final String firstName;
  final String lastName;
  UpdateUserName({
    required this.firstName,
    required this.lastName,
  });
}

class UpdateUserNameAndPicture extends ProfileEvent {
  final String firstName;
  final String lastName;
  final File picture;
  UpdateUserNameAndPicture({
    required this.firstName,
    required this.lastName,
    required this.picture,
  });
}

class UpdateProfileWithEmailAndPicture extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final File picture;
  UpdateProfileWithEmailAndPicture({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.picture,
  });
}

class UpdateProfileWithEmailAndName extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UpdateProfileWithEmailAndName({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}