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

class GetUserPosts extends PostsEvent {}

class DeletePost extends PostsEvent {
  final String post;
  DeletePost({
    required this.post,
  });
}

class EditPostContentAndImage extends PostsEvent {
  final String oldPost;
  final String newPost;
  final File newImage;
  EditPostContentAndImage({
    required this.oldPost,
    required this.newPost,
    required this.newImage,
  });
}

class EditPostContent extends PostsEvent {
  final String oldPost;
  final String newPost;
  EditPostContent({
    required this.oldPost,
    required this.newPost,
  });
}

class EditPostImage extends PostsEvent {
  final String oldPost;
  final File newImage;
  EditPostImage({
    required this.oldPost,
    required this.newImage,
  });
}
