import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLodingState extends ProfileState {}

class GetProfileDataSuccessState extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String profilePictureUrl;

  GetProfileDataSuccessState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
  });
}

class GetProfileDataErrorState extends ProfileState {
  final String error;

  GetProfileDataErrorState({required this.error});
}
