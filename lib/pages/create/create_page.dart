import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/pages/create/create_bloc/create_bloc.dart';
import 'package:swim_timer/pages/create/create_bloc/create_event.dart';
import 'package:swim_timer/pages/create/create_bloc/create_state.dart';
import 'package:swim_timer/pages/create/views/lane_settings_view.dart';
import 'package:swim_timer/pages/create/views/name_view.dart';
import 'package:swim_timer/pages/create/views/swimmer_selection_view.dart';

class CreatePage extends StatelessWidget {
  CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateBloc(),
        child: BlocBuilder<CreateBloc, CreateState>(
          builder: (context, state) {
            switch (state.currentStep) {
              case CreateStep.name:
                return NameView();
              case CreateStep.laneSettings:
                return LaneSettingsView();
              case CreateStep.swimmerSelection:
                return SwimmerSelectionView();
              default:
                return const Scaffold(
                  body: Center(
                    child: Text("Default"),
                  ),
                );
            }
          },
        ));
  }
}

// class CreateView extends StatefulWidget {
//   const CreateView({super.key, required this.bloc});

//   final CreateBloc bloc;

//   @override
//   State<CreateView> createState() => _CreateViewState();
// }

// class _CreateViewState extends State<CreateView> {
//   CreateStep? _step;

//   @override
//   void initState() {
//     _step = CreateStep.name;
//     widget.bloc.stream.forEach((state) {
//       setState(() {
//         _step = state.currentStep;
//       });
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       floatingActionButton: FloatingActionButton(onPressed: (() {
//         switch (_step) {
//           case CreateStep.name:
//             context
//                 .read<CreateBloc>()
//                 .add(CreateEvent_SetStep(step: CreateStep.laneSettings));
//             break;
//           case CreateStep.laneSettings:
//             context
//                 .read<CreateBloc>()
//                 .add(CreateEvent_SetStep(step: CreateStep.swimmerSelect));
//             break;
//           case CreateStep.swimmerSelect:
//             context
//                 .read<CreateBloc>()
//                 .add(CreateEvent_SetStep(step: CreateStep.name));
//             break;
//           default:
//         }
//       })),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: [
//               if (_step == CreateStep.name) Text('Enter Name'),
//               if (_step == CreateStep.laneSettings) Text('Enter Lane Count'),
//               if (_step == CreateStep.swimmerSelect) Text('Enter Swimmers'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
