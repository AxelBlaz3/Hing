import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      Image.asset('assets/onboarding_background.png',
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width),
      SafeArea(
          child: Container(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            S.of(context).loginToYourAccount,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty)
                                return S.of(context).emailCannotBeEmpty;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                                hintText: S.of(context).email,
                                prefixIcon: IconButton(
                                    onPressed: null,
                                    icon: SvgPicture.asset(
                                      'assets/mail.svg',
                                    ))),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty)
                                return S.of(context).passwordCannotBeEmpty;
                              else if (text.length < 8)
                                return S
                                    .of(context)
                                    .passwordMustBeAtLeast8Chars;
                            },
                            controller: _passwordController,
                            decoration: InputDecoration(
                                hintText: S.of(context).password,
                                prefixIcon: IconButton(
                                    onPressed: null,
                                    icon: SvgPicture.asset(
                                      'assets/lock.svg',
                                    ))),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => {
                                Navigator.of(context)
                                    .pushNamed(kResetPasswordRoute)
                              },
                              child: Text(S.of(context).forgotYourPassword),
                            ),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final AuthProvider authProvider =
                                  context.read<AuthProvider>();
                              authProvider
                                  .login(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((response) => (response is HingUser?)
                                      ? Navigator.of(context)
                                          .pushReplacementNamed(kHomeRoute)
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(response == 403
                                                  ? S
                                                      .of(context)
                                                      .incorrectCredentials
                                                  : S
                                                      .of(context)
                                                      .somethingWentWrong))));
                            },
                            child: Text(S.of(context).login),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width, 48)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.of(context)
                                  .pushReplacementNamed(kSignupRoute)
                            },
                            child: Text(S.of(context).createAccount),
                          ),
                        ],
                      )))))),
    ]));
  }
}
