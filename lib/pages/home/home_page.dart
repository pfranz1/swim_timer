import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Home",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
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
                  backgroundColor: Colors.green,
                  icon: Icon(
                    Icons.add_circle,
                    size: 60,
                    color: Colors.green,
                  ),
                  text: "Create",
                ),
                ActionButton(
                  onTap: () => context.go('/join'),
                  backgroundColor: Colors.blue,
                  icon: Icon(
                    Icons.groups_rounded,
                    size: 60,
                    color: Colors.blue,
                  ),
                  text: "Join",
                ),
                ActionButton(
                  onTap: () => context.go('/records'),
                  backgroundColor: Colors.orange,
                  icon: Icon(
                    Icons.menu_book,
                    size: 60.0,
                    color: Colors.orange,
                  ),
                  text: "Records ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          Future.delayed(Duration(milliseconds: 250))
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
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontWeight:
                                      _isHovered ? FontWeight.bold : null),
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
