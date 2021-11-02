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

  SignUpForParentButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.age,
    required this.gender,
  });
}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;
  SignInButtonPressed({required this.email, required this.password});
}

class SignOutButtonPressed extends AuthEvent {}
