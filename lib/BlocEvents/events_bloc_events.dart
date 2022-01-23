import 'dart:io';
import 'package:equatable/equatable.dart';

class EventsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventsStartEvent extends EventsEvent {}

class GetEvents extends EventsEvent {}

class JoinEvent extends EventsEvent {
  final String eventName;
  JoinEvent({required this.eventName});
}

class UnJoinEvent extends EventsEvent {
  final String eventName;
  UnJoinEvent({required this.eventName});
}

class InterestEvent extends EventsEvent {
  final String eventName;
  InterestEvent({required this.eventName});
}

class UnInterestEvent extends EventsEvent {
  final String eventName;
  UnInterestEvent({required this.eventName});
}

class AddEvent extends EventsEvent {
  final String name;
  final String facebookLink;
  final String bio;
  final File image;
  AddEvent({
    required this.name,
    required this.facebookLink,
    required this.bio,
    required this.image,
  });
}
