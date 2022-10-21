import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:entities/entities.dart';

class OverviewEvent extends Equatable {
  OverviewEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionRequested extends OverviewEvent {}

class StrokeFilterTapped extends OverviewEvent {
  StrokeFilterTapped({required this.stroke, required this.isAdding});

  final Stroke stroke;
  // If the stroke was previously not part of the filter
  final bool isAdding;

  List<Object> get props => [stroke, isAdding];
}
