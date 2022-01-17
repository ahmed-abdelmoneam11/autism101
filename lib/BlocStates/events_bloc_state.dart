import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventsState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventsInitialState extends EventsState {}

class EventsLodingState extends EventsState {}

class GetEventsSuccessState extends EventsState {
  final Stream<QuerySnapshot> events;
  GetEventsSuccessState({
    required this.events,
  });
}

class GetEventsErrorState extends EventsState {
  final String message;
  GetEventsErrorState({
    required this.message,
  });
}

// class JoinEventSuccessState extends EventsState {}

// class JoinEventErrorState extends EventsState {}

// class UnJoinEventSuccessState extends EventsState {}

// class UnJoinEventErrorState extends EventsState {}

// class InterestEventSuccessState extends EventsState {}

// class InterestEventErrorState extends EventsState {}

// class UnInterestEventSuccessState extends EventsState {}

// class UnInterestEventErrorState extends EventsState {}