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
        yield GetProfileDataErrorState(error: data['message']);
      } else if (data['code'] == 200) {
        yield GetProfileDataSuccessState(
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          profilePictureUrl: data['ProfilePicture'],
        );
      }
    }
  }
}
