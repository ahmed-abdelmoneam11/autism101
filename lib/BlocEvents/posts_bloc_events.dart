import 'dart:io';
import 'package:equatable/equatable.dart';

class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsStartEvent extends PostsEvent {}

class AddPost extends PostsEvent {
  final String post;
  AddPost({
    required this.post,
  });
}

class AddPostWithImage extends PostsEvent {
  final String post;
  final File postImage;
  AddPostWithImage({
    required this.post,
    required this.postImage,
  });
}

class AddComment extends PostsEvent {
  final String post;
  final String comment;
  AddComment({
    required this.post,
    required this.comment,
  });
}

class AddAgenda extends PostsEvent {
  final String title;
  final String content;
  AddAgenda({
    required this.title,
    required this.content,
  });
}

class GetUserPosts extends PostsEvent {}

class GetAgendas extends PostsEvent {}

class GetOtherUsersPosts extends PostsEvent {
  final userDocId;
  GetOtherUsersPosts({
    required this.userDocId,
  });
}

class GetTimeLinePosts extends PostsEvent {}

class GetFavouritePosts extends PostsEvent {}

class GetNotifications extends PostsEvent {}

class GetComments extends PostsEvent {
  final String postDocID;
  GetComments({
    required this.postDocID,
  });
}

class DeletePost extends PostsEvent {
  final String post;
  DeletePost({
    required this.post,
  });
}

class DeleteAgenda extends PostsEvent {
  final String agendaDocID;
  DeleteAgenda({
    required this.agendaDocID,
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

class EditPostAddImage extends PostsEvent {
  final String post;
  final File postImage;
  EditPostAddImage({
    required this.post,
    required this.postImage,
  });
}

class LikePost extends PostsEvent {
  final String post;
  LikePost({
    required this.post,
  });
}

class UnLikePost extends PostsEvent {
  final String post;
  UnLikePost({
    required this.post,
  });
}

class FavouritePost extends PostsEvent {
  final String post;
  FavouritePost({
    required this.post,
  });
}

class UnFavouritePost extends PostsEvent {
  final String post;
  UnFavouritePost({
    required this.post,
  });
}
