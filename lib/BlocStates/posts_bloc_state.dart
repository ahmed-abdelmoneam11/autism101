import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitialState extends PostsState {}

class PostsLodingState extends PostsState {}

class AddPostSuccessState extends PostsState {}

class AddPostErrorState extends PostsState {
  final String message;
  AddPostErrorState({
    required this.message,
  });
}

class GetUserPostsSuccessState extends PostsState {
  final Stream<QuerySnapshot> posts;
  GetUserPostsSuccessState({
    required this.posts,
  });
}

class GetUserPostsErrorState extends PostsState {
  final String message;
  GetUserPostsErrorState({
    required this.message,
  });
}
