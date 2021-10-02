import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/screens/components/toque_placeholder.dart';

class PublishingSheet extends StatefulWidget {
  const PublishingSheet({Key? key}) : super(key: key);

  @override
  _PublishingSheetState createState() => _PublishingSheetState();
}

class _PublishingSheetState extends State<PublishingSheet>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ToqueAnimation(),
        Text(
          S.of(context).hangOn,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 8,
        ),
        Text(S.of(context).publishingSummary)
      ],
    );
  }
}
