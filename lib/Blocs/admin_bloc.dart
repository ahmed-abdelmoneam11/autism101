import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/BlocData/admin_bloc_data.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminApi api;
  AdminBloc(AdminState initialState, this.api) : super(initialState);

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is AdminStartEvent) {
      yield AdminInitialState();
    } else if (event is GetMoviesEvent) {
      yield AdminLodingState();
      var data = await api.getMovies();
      if (data['code'] == 400) {
        yield GetMoviesErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetMoviesSuccessState(
          movies: data['data'],
        );
      }
    } else if (event is GetSchoolsEvent) {
      yield AdminLodingState();
      var data = await api.getUnVerifiedSchools();
      if (data['code'] == 400) {
        yield GetSchoolsErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetSchoolsSuccessState(
          schools: data['data'],
        );
      }
    } else if (event is GetInspiringEvent) {
      yield AdminLodingState();
      var data = await api.getInspiring();
      if (data['code'] == 400) {
        yield GetInspiringErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetInspiringSuccessState(
          inspiring: data['data'],
        );
      }
    } else if (event is GetActivitiesCoursesEvent) {
      yield AdminLodingState();
      var data = await api.getActivitiesCourses();
      if (data['code'] == 400) {
        yield GetActivitiesCoursesErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetActivitiesCoursesSuccessState(
          activitiesCourses: data['data'],
        );
      }
    } else if (event is GetSkillsCoursesEvent) {
      yield AdminLodingState();
      var data = await api.getSkillsCourses();
      if (data['code'] == 400) {
        yield GetSkillsCoursesErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetSkillsCoursesSuccessState(
          skillsCourses: data['data'],
        );
      }
    } else if (event is GetbehaviouralCoursesEvent) {
      yield AdminLodingState();
      var data = await api.getbehaviouralCourses();
      if (data['code'] == 400) {
        yield GetbehaviouralCoursesErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetbehaviouralCoursesSuccessState(
          behaviouralCourses: data['data'],
        );
      }
    } else if (event is DeleteMovie) {
      yield AdminLodingState();
      var data = await api.deleteMovie(event.movieName);
      if (data['code'] == 400) {
        yield DeleteMovieErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield DeleteMovieSuccessState();
      }
    } else if (event is DeleteInspiring) {
      yield AdminLodingState();
      var data = await api.deleteInspiring(event.name);
      if (data['code'] == 400) {
        yield DeleteInspiringErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield DeleteInspiringSuccessState();
      }
    } else if (event is DeleteUser) {
      yield AdminLodingState();
      var data = await api.deleteUser(event.email);
      if (data['code'] == 400) {
        yield DeleteUserErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield DeleteUserSuccessState();
      }
    } else if (event is AddMovie) {
      yield AdminLodingState();
      var data = await api.addMovie(
        event.movieName,
        event.movieActors,
        event.movieAgeRate,
        event.movieBrief,
        event.movieUrl,
        event.movieImage,
      );
      if (data['code'] == 400) {
        yield AddMovieErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield AddMovieSuccessState();
      }
    } else if (event is AddInspiring) {
      yield AdminLodingState();
      var data = await api.addInspiring(
        event.name,
        event.brief,
        event.date,
        event.autismCase,
        event.image,
      );
      if (data['code'] == 400) {
        yield AddInspiringErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield AddInspiringSuccessState();
      }
    } else if (event is AddCourse) {
      yield AdminLodingState();
      var data = await api.addCourse(
        event.name,
        event.url,
        event.type,
      );
      if (data['code'] == 400) {
        yield AddCourseErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield AddCourseSuccessState();
      }
    } else if (event is VerifySchoolEvent) {
      await api.verifySchool(event.webSite);
    }
  }
}
