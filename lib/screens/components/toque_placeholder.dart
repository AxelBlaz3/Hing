import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:lottie/lottie.dart';

class ToqueAnimation extends StatefulWidget {
  final double? size;
  const ToqueAnimation({Key? key, this.size}) : super(key: key);

  @override
  _ToqueAnimationState createState() => _ToqueAnimationState();
}

class _ToqueAnimationState extends State<ToqueAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat(period: Duration(seconds: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 56, bottom: 8),
              child: LottieBuilder.asset(
                'assets/toque_animation.json',
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..forward();
                },
              ))),
      Text(
        S.of(context).loading,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              fontSize: 10,
            ),
      ),
      SizedBox(
        height: 72,
      )
    ]);
  }
}
