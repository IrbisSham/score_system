import '../util/date_util.dart';
import 'bloc_event_state.component.dart';

class SpecFrequencyEvent extends BlocEvent {
  const SpecFrequencyEvent();
}

class ResetEvent extends SpecFrequencyEvent {
  final SpecFrequency frequency = SPEC_FREQUENCY_DEFAULT;

  ResetEvent();

  List<Object> get props => [frequency];
}

class UpEvent extends SpecFrequencyEvent {
  final SpecFrequency frequency;

  const UpEvent(this.frequency);

  List<Object> get props => [frequency];
}

class DownEvent extends SpecFrequencyEvent {
  final SpecFrequency frequency;

  const DownEvent(this.frequency);

  List<Object> get props => [frequency];
}