import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileStartEvent extends ProfileEvent {}

class GetProfileDataEvent extends ProfileEvent {}
