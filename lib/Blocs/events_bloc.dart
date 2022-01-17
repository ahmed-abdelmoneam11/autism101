import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/BlocEvents/events_bloc_events.dart';
import 'package:autism101/BlocStates/events_bloc_state.dart';
import 'package:autism101/BlocData/events_bloc_data.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsApi api;
  EventsBloc(EventsState initialState, this.api) : super(initialState);

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is EventsStartEvent) {
      yield EventsInitialState();
    } else if (event is GetEvents) {
      yield EventsLodingState();
      var data = await api.getEvents();
      if (data['code'] == 400) {
        yield GetEventsErrorState(
          message: data['message'],
        );
      } else if (data['code'] == 200) {
        yield GetEventsSuccessState(
          events: data['data'],
        );
      }
    } else if (event is JoinEvent) {
      yield EventsLodingState();
      await api.joinEvent(event.eventName);
    } else if (event is UnJoinEvent) {
      yield EventsLodingState();
      await api.unJoinEvent(event.eventName);
    } else if (event is InterestEvent) {
      yield EventsLodingState();
      await api.interestEvent(event.eventName);
    } else if (event is UnInterestEvent) {
      yield EventsLodingState();
      await api.unInterestEvent(event.eventName);
    }
  }
}
