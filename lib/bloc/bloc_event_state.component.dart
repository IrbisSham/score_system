import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  void dispose();
}

abstract class BlocEvent {
  const BlocEvent();
  List<Object> get props => [];
}

abstract class BlocState {
  List<Object> get props => [];
}

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  BlocEventStateBase({
    required this.initState,
  }) {
    _eventController.stream.listen((event) {
      final currentState = _stateController.value ?? initState;

      eventHandler(event, currentState).forEach((BlocState newState) {
        _stateController.sink.add(newState);
      });
    });
  }

  ///
  /// initialState
  ///
  final BlocState initState;

  ///
  /// External processing of the event
  ///
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  ///
  /// Current/New state
  ///
  Stream<BlocState> get state => _stateController.stream;

  ///
  /// To be invoked to emit an event
  ///
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }

  final StreamController<BlocEvent> _eventController = StreamController<BlocEvent>();

  final BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

}