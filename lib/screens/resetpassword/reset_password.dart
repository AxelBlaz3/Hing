import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset('assets/onboarding_background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width),
        SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButton(
                    color: Theme.of(context).colorScheme.onSurface,
                    onPressed: () => {
                      Navigator.of(context).pop()
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    S.of(context).resetYourPassword,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(S.of(context).resetPasswordHint),
                  SizedBox(height: 32),
                  TextField(
                    decoration: InputDecoration(
                        hintText: S.of(context).newPassword,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.visibility_rounded),
                            onPressed: () => {})),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: S.of(context).confirmPassword,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.visibility_rounded),
                            onPressed: () => {})),
                  ),
                ],
              ),
            )),
        SafeArea(
            child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(S.of(context).update),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      minimumSize: Size(MediaQuery.of(context).size.width, 48)),
                ))),
      ],
    ));
  }
}
