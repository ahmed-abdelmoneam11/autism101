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
        yield AddPostErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield AddPostSuccessState();
      }
    }
  }
}
