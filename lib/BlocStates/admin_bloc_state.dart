import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdminState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdminInitialState extends AdminState {}

class AdminLodingState extends AdminState {}

class GetMoviesSuccessState extends AdminState {
  final Stream<QuerySnapshot> movies;
  GetMoviesSuccessState({
    required this.movies,
  });
}

class GetMoviesErrorState extends AdminState {
  final String message;
  GetMoviesErrorState({
    required this.message,
  });
}

class GetInspiringSuccessState extends AdminState {
  final Stream<QuerySnapshot> inspiring;
  GetInspiringSuccessState({
    required this.inspiring,
  });
}

class GetInspiringErrorState extends AdminState {
  final String message;
  GetInspiringErrorState({
    required this.message,
  });
}

class DeleteMovieSuccessState extends AdminState {}

class DeleteMovieErrorState extends AdminState {
  final String message;
  DeleteMovieErrorState({required this.message});
}

class DeleteUserSuccessState extends AdminState {}

class DeleteUserErrorState extends AdminState {
  final String message;
  DeleteUserErrorState({required this.message});
}

class AddMovieSuccessState extends AdminState {}

class AddMovieErrorState extends AdminState {
  final String message;
  AddMovieErrorState({required this.message});
}
