import 'package:flutter/material.dart';

class TypeWriterTexts extends StatefulWidget {
  final String text;
  final Duration duration;
  final VoidCallback? onEnd; // 1. Added a new property for onEnd callback

  const TypeWriterTexts(
      {Key? key, required this.text, required this.duration, this.onEnd})
      : super(key: key); // Updated constructor to accept onEnd

  @override
  _TypeWriterTextsState createState() => _TypeWriterTextsState();
}

class _TypeWriterTextsState extends State<TypeWriterTexts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    // 2. Added a listener to call widget.onEnd when the animation is completed
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onEnd != null) {
          widget.onEnd!();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        int end = (_controller.value * widget.text.length).toInt();
        return Text(widget.text.substring(0, end));
      },
    );
  }
}
