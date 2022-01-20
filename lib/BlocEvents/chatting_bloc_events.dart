import 'package:equatable/equatable.dart';

class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatStartEvent extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String otherUserDocID;
  final String message;
  SendMessage({
    required this.otherUserDocID,
    required this.message,
  });
}

class GetChatRooms extends ChatEvent {}

class GetMessages extends ChatEvent {
  final String otherUserDocID;
  GetMessages({
    required this.otherUserDocID,
  });
}
