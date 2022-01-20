import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLodingState extends ChatState {}

class GettingChatRoomsSuccessState extends ChatState {
  final Stream<QuerySnapshot> chatRooms;
  GettingChatRoomsSuccessState({required this.chatRooms});
}

class GettingChatRoomsErrorState extends ChatState {
  final String message;
  GettingChatRoomsErrorState({required this.message});
}

class GettingMessagesSuccessState extends ChatState {
  final Stream<QuerySnapshot> messages;
  GettingMessagesSuccessState({required this.messages});
}

class GettingMessagesErrorState extends ChatState {
  final String message;
  GettingMessagesErrorState({required this.message});
}
