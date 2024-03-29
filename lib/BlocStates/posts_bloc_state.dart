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

class AddPostWithImageSuccessState extends PostsState {}

class AddPostWithImageErrorState extends PostsState {
  final String message;
  AddPostWithImageErrorState({
    required this.message,
  });
}

class AddAgendaSuccessState extends PostsState {}

class AddAgendaErrorState extends PostsState {
  final String message;
  AddAgendaErrorState({
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

class GetOtherUsersPostsSuccessState extends PostsState {
  final Stream<QuerySnapshot> posts;
  GetOtherUsersPostsSuccessState({
    required this.posts,
  });
}

class GetOtherUsersPostsErrorState extends PostsState {
  final String message;
  GetOtherUsersPostsErrorState({
    required this.message,
  });
}

class GetTimeLinePostsSuccessState extends PostsState {
  final Stream<QuerySnapshot> posts;
  GetTimeLinePostsSuccessState({
    required this.posts,
  });
}

class GetTimeLinePostsErrorState extends PostsState {
  final String message;
  GetTimeLinePostsErrorState({
    required this.message,
  });
}

class GetFavouritePostsSuccessState extends PostsState {
  final Stream<QuerySnapshot> posts;
  GetFavouritePostsSuccessState({
    required this.posts,
  });
}

class GetFavouritePostsErrorState extends PostsState {
  final String message;
  GetFavouritePostsErrorState({
    required this.message,
  });
}

class GetNotificationsSuccessState extends PostsState {
  final Stream<QuerySnapshot> notifications;
  GetNotificationsSuccessState({
    required this.notifications,
  });
}

class GetNotificationsErrorState extends PostsState {
  final String message;
  GetNotificationsErrorState({
    required this.message,
  });
}

class GetCommentsSuccessState extends PostsState {
  final Stream<QuerySnapshot> comments;
  GetCommentsSuccessState({
    required this.comments,
  });
}

class GetCommentsErrorState extends PostsState {
  final String message;
  GetCommentsErrorState({
    required this.message,
  });
}

class GetAgendasSuccessState extends PostsState {
  final Stream<QuerySnapshot> agendas;
  GetAgendasSuccessState({
    required this.agendas,
  });
}

class GetAgendasErrorState extends PostsState {
  final String message;
  GetAgendasErrorState({
    required this.message,
  });
}

class DeletePostSuccessState extends PostsState {}

class DeletePostErrorState extends PostsState {
  final String message;
  DeletePostErrorState({
    required this.message,
  });
}

class EditPostContentAndImageSuccessState extends PostsState {}

class EditPostContentAndImageErrorState extends PostsState {
  final String message;
  EditPostContentAndImageErrorState({required this.message});
}

class EditPostContentSuccessState extends PostsState {}

class EditPostContentErrorState extends PostsState {
  final String message;
  EditPostContentErrorState({required this.message});
}

class EditPostImageSuccessState extends PostsState {}

class EditPostImageErrorState extends PostsState {
  final String message;
  EditPostImageErrorState({required this.message});
}

class EditPostAddImageSuccessState extends PostsState {}

class EditPostAddImageErrorState extends PostsState {
  final String message;
  EditPostAddImageErrorState({required this.message});
}
