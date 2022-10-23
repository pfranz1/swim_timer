import 'package:equatable/equatable.dart';
import 'package:provider/provider.dart';

enum CreateStep { name, laneSettings, swimmerSelection }

class CreateState extends Equatable {
  final CreateStep currentStep;
  final String? practiceName;

  CreateState({required this.currentStep, this.practiceName});

  CreateState copyWith(
      {CreateStep? currentStep, String? Function()? practiceName}) {
    return CreateState(
      currentStep: currentStep ?? this.currentStep,
      practiceName: practiceName != null ? practiceName() : this.practiceName,
    );
  }

  List<Object?> get props => [currentStep, practiceName];
}
