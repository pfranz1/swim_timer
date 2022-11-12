import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/custom_colors.dart';
import 'package:swim_timer/pages/join/practice_tile.dart';

class JoinPage extends StatelessWidget {
  JoinPage({super.key});

  // TODO: Replace with backend integration
  final List<PracticeDM> practices = [
    PracticeDM(
        name: "Six and Unders",
        id: "1111",
        numSwimmers: 3,
        createdOn: DateTime.now()),
    PracticeDM(
        name: "Seven and Eights",
        id: "2222",
        numSwimmers: 12,
        createdOn: DateTime.now()),
    PracticeDM(
        name: "Sprints after clinic",
        id: "1333",
        numSwimmers: 19,
        createdOn: DateTime.now().subtract(Duration(days: 1))),
    // PracticeDM(
    //     name: "Sprints before clinic",
    //     id: "4213",
    //     numSwimmers: 19,
    //     createdOn: DateTime.now().subtract(Duration(days: 2))),
    PracticeDM(
        name: "12+ Meet Seed Times",
        id: "67556",
        numSwimmers: 87,
        createdOn: DateTime.now().subtract(Duration(days: 4))),
    // PracticeDM(
    //     name: "Six and Unders",
    //     id: "6875",
    //     numSwimmers: 6,
    //     createdOn: DateTime.now().subtract(Duration(days: 4))),
    // PracticeDM(
    //     name: "Afternoon Practice Sprints",
    //     id: "8582",
    //     numSwimmers: 11,
    //     createdOn: DateTime.now().subtract(Duration(days: 4))),
    PracticeDM(
        name: "Morning Practice Sprints",
        id: "4329",
        numSwimmers: 18,
        createdOn: DateTime.now().subtract(Duration(days: 4))),
    PracticeDM(
        name: "Cork Screw Tournament",
        id: "4326",
        numSwimmers: 33,
        createdOn: DateTime.now().subtract(Duration(days: 5))),
    PracticeDM(
        name: "12+ Weekly Benchmark",
        id: "5768",
        numSwimmers: 34,
        createdOn: DateTime.now().subtract(Duration(days: 5))),
    // PracticeDM(
    //     name: "City Meet Seed Times",
    //     id: "5642",
    //     numSwimmers: 50,
    //     createdOn: DateTime.now().subtract(Duration(days: 6))),
    // PracticeDM(
    //     name: "Test Practice",
    //     id: "4323",
    //     numSwimmers: 1,
    //     createdOn: DateTime.now().subtract(Duration(days: 8))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Join"),
        leading: IconButton(
            onPressed: () => {context.go('/')},
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: CustomColors.backgroundGradient),
        child: Center(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PracticeTile(
                    practice: practices[index],
                  ),
                );
              },
              itemCount: practices.length),
        ),
      ),
    );
  }
}
