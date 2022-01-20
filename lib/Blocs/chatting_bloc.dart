import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/BlocEvents/chatting_bloc_events.dart';
import 'package:autism101/BlocStates/chatting_bloc_state.dart';
import 'package:autism101/BlocData/chatting_bloc_data.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatApi api;
  ChatBloc(ChatState initialState, this.api) : super(initialState);

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatStartEvent) {
      yield ChatInitialState();
    } else if (event is SendMessage) {
      await api.sendMessage(
        event.otherUserDocID,
        event.message,
      );
    } else if (event is GetChatRooms) {
      yield ChatLodingState();
      var data = await api.gettingChatRooms();
      if (data['code'] == 400) {
        yield GettingChatRoomsErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield GettingChatRoomsSuccessState(chatRooms: data['data']);
      }
    } else if (event is GetMessages) {
      yield ChatLodingState();
      var data = await api.gettingMessages(event.otherUserDocID);
      if (data['code'] == 400) {
        yield GettingMessagesErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield GettingMessagesSuccessState(messages: data['data']);
      }
    }
  }
}
