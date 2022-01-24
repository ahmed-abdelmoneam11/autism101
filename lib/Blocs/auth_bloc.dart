import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/BlocData/auth_bloc_data.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthApi api;
  AuthBloc(AuthState initialState, this.api) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is StartEvent) {
      yield InitialState();
    } else if (event is SignUpForParentButtonPressed) {
      yield LodingState();
      var data = await api.signUpForParent(
        event.firstName,
        event.lastName,
        event.email,
        event.phone,
        event.password,
        event.age,
        event.gender,
        event.profilePicture,
      );
      if (data['code'] == 400) {
        yield SignUpForParentErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield SignUpForParentSuccessState();
      }
    } else if (event is SignUpForSchoolButtonPressed) {
      yield LodingState();
      var data = await api.signUpForShool(
        event.name,
        event.phone,
        event.webSite,
        event.address,
        event.password,
        event.profilePicture,
      );
      if (data['code'] == 400) {
        yield SignUpForSchoolErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield SignUpForSchoolSuccessState();
      }
    } else if (event is SignInButtonPressed) {
      yield LodingState();
      var data = await api.signIn(event.email, event.password);
      if (data['code'] == 400) {
        yield SignInErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield SignInSuccessState();
      }
    } else if (event is SignOutButtonPressed) {
      yield LodingState();
      await api.signOut();
      yield SignOutSuccessState();
    } else if (event is SendConfirmationCode) {
      await api.sendCode(event.email);
    } else if (event is ResetPassword) {
      yield LodingState();
      var data = await api.resetPassword(event.code, event.newPassword);
      if (data['code'] == 400) {
        yield ResetPasswordErrorState(message: data['message']);
      } else if (data['code'] == 200) {
        yield ResetPasswordSuccessState();
      }
    }
  }
}
