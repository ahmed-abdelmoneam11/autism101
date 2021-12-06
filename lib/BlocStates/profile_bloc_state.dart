import 'package:cloud_firestore/cloud_firestore.dart';
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
  final int postsCount;
  final int followingCount;
  final int followersCount;

  GetProfileDataSuccessState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
    required this.postsCount,
    required this.followingCount,
    required this.followersCount,
  });
}

class GetProfileDataErrorState extends ProfileState {
  final String error;

  GetProfileDataErrorState({required this.error});
}

class GetOtherUsersProfileDataSuccessState extends ProfileState {
  final String firstName;
  final String lastName;
  final String profilePictureUrl;
  final int postsCount;
  final int followingCount;
  final int followersCount;

  GetOtherUsersProfileDataSuccessState({
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.postsCount,
    required this.followingCount,
    required this.followersCount,
  });
}

class GetOtherUsersProfileDataErrorState extends ProfileState {
  final String message;

  GetOtherUsersProfileDataErrorState({
    required this.message,
  });
}

class SearchUsersSuccessState extends ProfileState {
  final Stream<QuerySnapshot> users;
  SearchUsersSuccessState({
    required this.users,
  });
}

class SearchUsersErrorState extends ProfileState {
  final String message;

  SearchUsersErrorState({
    required this.message,
  });
}

class UpdateUserNameSuccessState extends ProfileState {
  final String message;
  UpdateUserNameSuccessState({
    required this.message,
  });
}

class UpdateUserNameAndPictureSuccessState extends ProfileState {
  final String message;
  UpdateUserNameAndPictureSuccessState({
    required this.message,
  });
}

class UpdateProfileWithEmailAndPictureSuccessState extends ProfileState {
  final String message;
  UpdateProfileWithEmailAndPictureSuccessState({
    required this.message,
  });
}

class UpdateProfileWithEmailAndNameSuccessState extends ProfileState {
  final String message;
  UpdateProfileWithEmailAndNameSuccessState({
    required this.message,
  });
}

class UpdateUserNameErrorState extends ProfileState {
  final String message;
  UpdateUserNameErrorState({
    required this.message,
  });
}

class UpdateUserNameAndPictureErrorState extends ProfileState {
  final String message;
  UpdateUserNameAndPictureErrorState({
    required this.message,
  });
}

class UpdateProfileWithEmailAndPictureErrorState extends ProfileState {
  final String message;
  UpdateProfileWithEmailAndPictureErrorState({
    required this.message,
  });
}

class UpdateProfileWithEmailAndNameErrorState extends ProfileState {
  final String message;
  UpdateProfileWithEmailAndNameErrorState({
    required this.message,
  });
}
