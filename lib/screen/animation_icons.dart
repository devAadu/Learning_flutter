import 'package:flutter/material.dart';

class AnimationIcons extends StatefulWidget {
  const AnimationIcons({Key? key}) : super(key: key);

  @override
  State<AnimationIcons> createState() => _AnimationIconsState();
}

class _AnimationIconsState extends State<AnimationIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  @override
  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              _handleOnPressed();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _animationController,
              size: 50,
              color: Colors.red,
            )),
        IconButton(
            onPressed: () {
              _handleOnPressed();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.ellipsis_search,
              progress: _animationController,
              size: 50,
              color: Colors.red,
            )),
        IconButton(
            onPressed: () {
              _handleOnPressed();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animationController,
              size: 50,
              color: Colors.red,
            )),
      ],
    );
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}
