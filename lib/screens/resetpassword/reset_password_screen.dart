import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isValidated = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

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
              child: Form(
                  key: _formKey,
                  onChanged: () {
                    setState(() {
                      isValidated = _formKey.currentState?.validate() ?? false;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(
                        color: Theme.of(context).colorScheme.onSurface,
                        onPressed: () => {Navigator.of(context).pop()},
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
                      Text(S.of(context).resetNewPasswordSummary),
                      SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        validator: (text) => text == null || text.isEmpty
                            ? S.of(context).emailCannotBeEmpty
                            : !emailRegexPattern.hasMatch(text)
                                ? S.of(context).enterAValidEmail
                                : null,
                        decoration: InputDecoration(
                          hintText: S.of(context).email,
                        ),
                      ),
                    ],
                  )),
            )),
        SafeArea(
            child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: !isValidated
                      ? null
                      : () {
                          final UserProvider userProvider =
                              context.read<UserProvider>();

                          userProvider
                              .sendVerificationCode(
                                  email: _emailController.text)
                              .then((success) => success
                                  ? Navigator.of(context)
                                      .pushNamed(kCreatePasswordRoute, arguments: _emailController.text)
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .somethingWentWrong))));
                        },
                  child: Text(S.of(context).sendInstructions),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      minimumSize: Size(MediaQuery.of(context).size.width, 48)),
                ))),
      ],
    ));
  }
}
