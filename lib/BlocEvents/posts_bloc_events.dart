import 'dart:io';
import 'package:equatable/equatable.dart';

class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsStartEvent extends PostsEvent {}

class AddPost extends PostsEvent {
  final String post;
  final File postImage;
  AddPost({
    required this.post,
    required this.postImage,
  });
}
