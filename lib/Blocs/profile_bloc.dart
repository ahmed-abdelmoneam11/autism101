import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/BlocData/profile_bloc_data.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileApi api;
  ProfileBloc(ProfileState initialState, this.api) : super(initialState);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileStartEvent) {
      yield ProfileInitialState();
    } else if (event is GetProfileDataEvent) {
      yield ProfileLodingState();
      var data = await api.getProfileData();
      if (data['code'] == 400) {
        yield GetProfileDataErrorState(
          error: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetProfileDataSuccessState(
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          profilePictureUrl: data['ProfilePicture'],
          postsCount: data['postsCount'],
          followingCount: data['followingCount'],
          followersCount: data['followersCount'],
        );
      }
    } else if (event is GetOtherUsersProfileDataEvent) {
      yield ProfileLodingState();
      var data = await api.getOtherUsersProfileData(event.userDocId);
      if (data['code'] == 400) {
        yield GetOtherUsersProfileDataErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetOtherUsersProfileDataSuccessState(
          firstName: data['firstName'],
          lastName: data['lastName'],
          profilePictureUrl: data['ProfilePicture'],
          followers: data['followers'],
          postsCount: data['postsCount'],
          followingCount: data['followingCount'],
          followersCount: data['followersCount'],
        );
      }
    } else if (event is GetPeopleYouMayKnowEvent) {
      yield ProfileLodingState();
      var data = await api.getPeopleYouMayKnow();
      if (data['code'] == 400) {
        yield GetPeopleYouMayKnowErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield GetPeopleYouMayKnowSuccessState(users: data['data']);
      }
    } else if (event is GetSchoolsEvent) {
      yield ProfileLodingState();
      var data = await api.getSchools();
      if (data['code'] == 400) {
        yield GetSchoolsErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield GetSchoolsSuccessState(schools: data['data']);
      }
    } else if (event is UpdateUserName) {
      yield ProfileLodingState();
      var data = await api.updateProfileName(
        event.firstName,
        event.lastName,
      );
      if (data['code'] == 400) {
        yield UpdateUserNameErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield UpdateUserNameSuccessState(message: data['message']);
      }
    } else if (event is UpdateProfileWithEmailAndName) {
      yield ProfileLodingState();
      var data = await api.updateProfileNameAndEmail(
        event.firstName,
        event.lastName,
        event.email,
        event.password,
      );
      if (data['code'] == 400) {
        yield UpdateProfileWithEmailAndNameErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield UpdateProfileWithEmailAndNameSuccessState(
            message: data['message']);
      }
    } else if (event is UpdateProfileWithEmailAndPicture) {
      yield ProfileLodingState();
      var data = await api.updateProfileEmailAndPicture(
        event.firstName,
        event.lastName,
        event.email,
        event.password,
        event.picture,
      );
      if (data['code'] == 400) {
        yield UpdateProfileWithEmailAndPictureErrorState(
            message: data['message']);
      } else if (data['code'] == 200) {
        yield UpdateProfileWithEmailAndPictureSuccessState(
            message: data['message']);
      }
    } else if (event is UpdateUserNameAndPicture) {
      yield ProfileLodingState();
      var data = await api.updateProfileNameAndPicture(
        event.firstName,
        event.lastName,
        event.picture,
      );
      if (data['code'] == 400) {
        yield UpdateUserNameAndPictureErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield UpdateUserNameAndPictureSuccessState(message: data['message']);
      }
    } else if (event is SearchUsers) {
      yield ProfileLodingState();
      var data = await api.searchUser(
        event.query,
      );
      if (data['code'] == 400) {
        yield SearchUsersErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield SearchUsersSuccessState(users: data['data']);
      }
    } else if (event is FollowUser) {
      await api.followUser(event.userDocID);
    } else if (event is UnFollowUser) {
      await api.unFollowUser(event.userDocID);
    } else if (event is FollowSchool) {
      await api.followSchool(event.schoolDocID);
    } else if (event is UnFollowSchool) {
      await api.unFollowSchool(event.schoolDocID);
    }
  }
}
