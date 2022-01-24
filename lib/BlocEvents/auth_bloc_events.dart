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
  final String name;
  final String webSite;
  final String address;
  final String password;
  final File profilePicture;

  SignUpForSchoolButtonPressed({
    required this.phone,
    required this.name,
    required this.webSite,
    required this.address,
    required this.password,
    required this.profilePicture,
  });
}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;
  SignInButtonPressed({required this.email, required this.password});
}

class SignOutButtonPressed extends AuthEvent {}

class SendConfirmationCode extends AuthEvent {
  final String email;
  SendConfirmationCode({required this.email});
}

class ResetPassword extends AuthEvent {
  final String code;
  final String newPassword;
  ResetPassword({
    required this.code,
    required this.newPassword,
  });
}
