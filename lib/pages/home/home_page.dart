import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/customcolors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: CustomColors.primeColor,
                  )),
            )
          ],
          title: Text("Home",
              style: TextStyle(
                  color: CustomColors.primeColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE6F3F9), Color(0xFFC6E3EE), Color(0xFFAAF6FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ActionButton(
                      onTap: () => context.go('/create'),
                      backgroundColor: Color(0xFF56FFB8),
                      icon: Icon(
                        Icons.add_circle,
                        size: 60,
                        color: Color(0xFF56FFB8),
                      ),
                      text: "New Practice",
                    ),
                    ActionButton(
                      onTap: () => context.go('/join'),
                      backgroundColor: Colors.blue,
                      icon: Icon(
                        Icons.groups_rounded,
                        size: 60,
                        color: Color(0xFF2ABFFF),
                      ),
                      text: "Join Practice",
                    ),
                    ActionButton(
                      onTap: () {
                        // context.go('/records'),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Records coming soon!'),
                          ],
                        )));
                      },
                      backgroundColor: Color(0xFF0677BA),
                      icon: Icon(
                        Icons.ssid_chart_sharp,
                        size: 60.0,
                        color: Color(0xFF0677BA),
                      ),
                      text: "View Records",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ActionButton extends StatefulWidget {
  const ActionButton(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.text,
      required this.icon});

  final void Function() onTap;
  final String text;
  final Color backgroundColor;
  final Widget icon;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        splashColor: widget.backgroundColor,
        radius: 500,
        onTap: () {
          setState(() {
            _isHovered = true;
          });
          Future.delayed(Duration(milliseconds: 75))
              .then((value) => widget.onTap());
        },
        onHover: (value) => setState(() {
          _isHovered = value;
        }),
        child: Container(
          constraints: BoxConstraints(minHeight: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: _isHovered
                  ? Border.all(
                      width: 5.0,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5))
                  : null),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Center(child: widget.icon)),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: 15,
                            color: CustomColors.primeColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
