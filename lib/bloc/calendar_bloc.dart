import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_system/bloc/calendar_state.dart';
import '../util/date_util.dart';
import 'calendar_event.dart';

class SpecFrequencyBloc extends Bloc<SpecFrequencyEvent, SpecFrequencyState> {

  SpecFrequency currentFrequency;

  SpecFrequencyBloc(this.currentFrequency) : super(SpecFrequencyDefault()) {
    on<SpecFrequencyEvent>((event, emit) {
      switch (event.runtimeType) {
        case ResetEvent:
          emit(SpecFrequencyDefault());
          break;
        case UpEvent:
          emit(getState((event.props[0] as SpecFrequency).add(1)));
          break;
        case DownEvent:
          emit(getState((event.props[0] as SpecFrequency).substract(1)));
      }
    });
  }

  SpecFrequencyState getState(SpecFrequency specFrequency) {
    SpecFrequencyState rez = SpecFrequencyDefault();
    switch (specFrequency.specFreq) {
      case SPEC_FREQ.DAY:
        rez = SpecFrequencyDay();
        break;
      case SPEC_FREQ.WEEK:
        rez = SpecFrequencyWeek();
        break;
      case SPEC_FREQ.MONTH:
        rez = SpecFrequencyMonth();
        break;
      case SPEC_FREQ.YEAR:
        rez = SpecFrequencyYear();
        break;
    }
    return rez;
  }

}