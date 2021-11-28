import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/BlocData/posts_bloc_data.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsApi api;
  PostsBloc(PostsState initialState, this.api) : super(initialState);

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is PostsStartEvent) {
      yield PostsInitialState();
    } else if (event is AddPost) {
      yield PostsLodingState();
      var data = await api.addPost(
        event.post,
        event.postImage,
      );
      if (data['code'] == 400) {
        yield AddPostErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield AddPostSuccessState();
      }
    } else if (event is GetUserPosts) {
      yield PostsLodingState();
      var data = await api.getUserPosts();
      if (data['code'] == 400) {
        yield GetUserPostsErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetUserPostsSuccessState(
          posts: data['data'],
        );
      }
    } else if (event is EditPostContentAndImage) {
      yield PostsLodingState();
      var data = await api.editPostContentAndImage(
        event.oldPost,
        event.newPost,
        event.newImage,
      );
      if (data['code'] == 400) {
        yield EditPostContentAndImageErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield EditPostContentAndImageSuccessState();
      }
    } else if (event is EditPostContent) {
      yield PostsLodingState();
      var data = await api.editPostContent(
        event.oldPost,
        event.newPost,
      );
      if (data['code'] == 400) {
        yield EditPostContentErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield EditPostContentSuccessState();
      }
    } else if (event is EditPostImage) {
      yield PostsLodingState();
      var data = await api.editPostImage(
        event.oldPost,
        event.newImage,
      );
      if (data['code'] == 400) {
        yield EditPostImageErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield EditPostImageSuccessState();
      }
    } else if (event is DeletePost) {
      yield PostsLodingState();
      var data = await api.deletePost(event.post);
      if (data['code'] == 400) {
        yield DeletePostErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield DeletePostSuccessState();
      }
    }
  }
}
