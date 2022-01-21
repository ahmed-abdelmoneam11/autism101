import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}

class LodingState extends AuthState {}

class SignUpForParentSuccessState extends AuthState {}

class SignUpForParentErrorState extends AuthState {
  final String message;
  SignUpForParentErrorState({required this.message});
}

class SignUpForSchoolSuccessState extends AuthState {}

class SignUpForSchoolErrorState extends AuthState {
  final String message;
  SignUpForSchoolErrorState({required this.message});
}

class SignInSuccessState extends AuthState {}

class SignInErrorState extends AuthState {
  final String message;
  SignInErrorState({required this.message});
}

class SignOutSuccessState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordErrorState extends AuthState {
  final String message;
  ResetPasswordErrorState({required this.message});
}
