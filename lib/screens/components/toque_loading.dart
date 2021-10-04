import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:lottie/lottie.dart';

class ToqueLoading extends StatefulWidget {
  final double? size;
  const ToqueLoading({Key? key, this.size}) : super(key: key);

  @override
  _ToqueLoadingState createState() => _ToqueLoadingState();
}

class _ToqueLoadingState extends State<ToqueLoading>
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
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              height: widget.size ?? 144,
              width: widget.size ?? 144,
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: LottieBuilder.asset(
                    'assets/toque_animation.json',
                    height: widget.size ?? 144,
                    width: widget.size ?? 144,
                    controller: _animationController,
                    onLoaded: (composition) {
                      _animationController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ))),
          Text(
            S.of(context).hangOn,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).publishingSummary,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ]));
  }
}
