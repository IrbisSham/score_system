import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:score_system/util/date_util.dart';

@immutable
abstract class SpecFrequencyState extends Equatable {

  final SpecFrequency frequency;

  SpecFrequencyState({required this.frequency});

}

class SpecFrequencyDefault extends SpecFrequencyState {

  SpecFrequencyDefault() : super(frequency: SPEC_FREQUENCY_DEFAULT);

  @override
  List<Object> get props => [frequency];
}

class SpecFrequencyBase extends SpecFrequencyState {

  final SpecFrequency frequency;

  SpecFrequencyBase({required this.frequency}) : super(frequency: frequency);

  @override
  List<Object> get props => [frequency];
}



class SpecFrequencyDay extends SpecFrequencyState {

  SpecFrequencyDay() : super(frequency: SpecFrequency(specFreq: SPEC_FREQ.DAY));

  @override
  List<Object> get props => [frequency];
}

class SpecFrequencyWeek extends SpecFrequencyState {

  SpecFrequencyWeek() : super(frequency: SpecFrequency(specFreq: SPEC_FREQ.WEEK));

  @override
  List<Object> get props => [frequency];

}

class SpecFrequencyMonth extends SpecFrequencyState {

  SpecFrequencyMonth() : super(frequency: SpecFrequency(specFreq: SPEC_FREQ.MONTH));

  @override
  List<Object> get props => [frequency];

}

class SpecFrequencyYear extends SpecFrequencyState {

  SpecFrequencyYear() : super(frequency: SpecFrequency(specFreq: SPEC_FREQ.YEAR));

  @override
  List<Object> get props => [frequency];

}