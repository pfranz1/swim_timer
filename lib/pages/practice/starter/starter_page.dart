import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) =>
          StarterBloc(practiceRepository: context.read<PracticeRepository>())
            ..add(SubscriptionRequested())),
      child: const StarterView(),
    );
  }
}

class StarterView extends StatelessWidget {
  const StarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Starter View Rendered!')),
    );
  }
}
