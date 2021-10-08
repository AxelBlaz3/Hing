import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  final int index;
  const OnboardingScreen({Key? key, required this.index}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  Widget build(BuildContext context) {
    //  print('Deep link - ${ModalRoute.of(context)?.settings.arguments}');
    return Scaffold(
        body: Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset('assets/onboarding_background.png',
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width),
        SafeArea(
            child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/logo.svg',
                      height: 48,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      widget.index == 1
                          ? S.of(context).onboardingOneTitle
                          : S.of(context).onboardingTwoTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      widget.index == 1
                          ? S.of(context).onboardingOneSummary
                          : S.of(context).onboardingTwoSummary,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (widget.index < 2) {
                          Navigator.of(context).pushNamed(kOnBoardingRoute,
                              arguments: widget.index + 1);
                        } else {
                          // Update shared preferences and set onBoardingDone to true.
                          (await SharedPreferences.getInstance())
                              .setBool(kOnBoardingPrefKey, true);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              kLoginRoute, (route) => false);
                        }
                      },
                      child: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 48),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                      ),
                    )
                  ],
                )))
      ],
    ));
  }
}
