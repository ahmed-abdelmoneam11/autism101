import 'dart:io';
import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartEvent extends AuthEvent {}

class SignUpForParentButtonPressed extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String age;
  final String gender;
  final File profilePicture;

  SignUpForParentButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.age,
    required this.gender,
    required this.profilePicture,
  });
}

class SignUpForSchoolButtonPressed extends AuthEvent {
  final String phone;
  final String webSite;
  final String address;
  final String password;

  SignUpForSchoolButtonPressed({
    required this.phone,
    required this.webSite,
    required this.address,
    required this.password,
  });
}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;
  SignInButtonPressed({required this.email, required this.password});
}

class SignOutButtonPressed extends AuthEvent {}
