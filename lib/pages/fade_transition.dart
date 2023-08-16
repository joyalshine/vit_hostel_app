import 'package:flutter/material.dart';

class FadeTransitionContainer extends StatefulWidget {
  const FadeTransitionContainer({super.key, required this.screen});

  final Widget screen;
  @override
  State<FadeTransitionContainer> createState() => _FadeTransitionContainerState();
}
class _FadeTransitionContainerState extends State<FadeTransitionContainer>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    _controller.forward(); // Start the animation to make MainPage fade in
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: FadeTransition(
        opacity: _controller,
        child: widget.screen,
      ),
    );
  }
}