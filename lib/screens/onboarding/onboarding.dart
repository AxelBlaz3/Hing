import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  'assets/onboarding_background.svg',
                  fit: BoxFit.cover,
                ))),
        Padding(
            padding: EdgeInsets.all(48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Find your comfort food here',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Some weird description making up to two lines. At least two lines.',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 48,
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 48),
                    padding: EdgeInsets.all(24),
                  ),
                )
              ],
            ))
      ],
    ));
  }
}
