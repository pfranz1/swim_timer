import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
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
                  backgroundColor: Colors.orange,
                  text: "Create",
                ),
                ActionButton(
                  onTap: () => context.go('/join'),
                  backgroundColor: Colors.green,
                  text: "Join",
                ),
                ActionButton(
                  onTap: () => context.go('/records'),
                  backgroundColor: Colors.blue,
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
      required this.text});

  final void Function() onTap;
  final String text;
  final Color backgroundColor;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      onHover: (value) => setState(() {
        _isHovered = value;
      }),
      style: ElevatedButton.styleFrom(backgroundColor: widget.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.text,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: _isHovered ? Colors.white : null)),
      ),
    );
  }
}
