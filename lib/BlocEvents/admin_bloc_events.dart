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

class AddInspiring extends AdminEvent {
  final String name;
  final String brief;
  final String date;
  final String autismCase;
  final File image;
  AddInspiring({
    required this.name,
    required this.brief,
    required this.date,
    required this.autismCase,
    required this.image,
  });
}

class AddCourse extends AdminEvent {
  final String name;
  final String url;
  final String type;
  AddCourse({
    required this.name,
    required this.url,
    required this.type,
  });
}

class GetMoviesEvent extends AdminEvent {}

class GetSchoolsEvent extends AdminEvent {}

class GetInspiringEvent extends AdminEvent {}

class GetActivitiesCoursesEvent extends AdminEvent {}

class GetSkillsCoursesEvent extends AdminEvent {}

class GetbehaviouralCoursesEvent extends AdminEvent {}

class DeleteMovie extends AdminEvent {
  final String movieName;
  DeleteMovie({required this.movieName});
}

class DeleteUser extends AdminEvent {
  final String email;
  DeleteUser({required this.email});
}

class DeleteInspiring extends AdminEvent {
  final String name;
  DeleteInspiring({required this.name});
}

class VerifySchoolEvent extends AdminEvent {
  final String webSite;
  VerifySchoolEvent({required this.webSite});
}
