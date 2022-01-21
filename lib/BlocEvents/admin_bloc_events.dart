import 'dart:io';
import 'package:equatable/equatable.dart';

class AdminEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminStartEvent extends AdminEvent {}

class AddMovie extends AdminEvent {
  final String movieName;
  final String movieBrief;
  final String movieAgeRate;
  final String movieActors;
  final String movieUrl;
  final File movieImage;
  AddMovie({
    required this.movieName,
    required this.movieBrief,
    required this.movieAgeRate,
    required this.movieActors,
    required this.movieUrl,
    required this.movieImage,
  });
}

class GetMoviesEvent extends AdminEvent {}

class GetInspiringEvent extends AdminEvent {}

class DeleteMovie extends AdminEvent {
  final String movieName;
  DeleteMovie({required this.movieName});
}

class DeleteUser extends AdminEvent {
  final String email;
  DeleteUser({required this.email});
}
