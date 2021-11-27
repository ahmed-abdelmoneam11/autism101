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
