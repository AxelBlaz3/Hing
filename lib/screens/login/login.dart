import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/circular_indicator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isValidated = false;
  bool _obscurePassword = true;

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
                          key: _formKey,
                          onChanged: () {
                            setState(() {
                              isValidated =
                                  _formKey.currentState?.validate() ?? false;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                MediaQuery.of(context).platformBrightness ==
                                        Brightness.light
                                    ? 'assets/logo.svg'
                                    : 'assets/logo_dark.svg',
                                height: 48,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                S.of(context).loginToYourAccount,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              TextFormField(
                                validator: (text) =>
                                    text == null || text.isEmpty
                                        ? S.of(context).emailCannotBeEmpty
                                        : null,
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
                                validator: (text) =>
                                    text == null || text.isEmpty
                                        ? S.of(context).passwordCannotBeEmpty
                                        : null,
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                    hintText: S.of(context).password,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                        icon: Icon(Icons.visibility_rounded,
                                            color: !_obscurePassword
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.grey)),
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
                              Consumer<UserProvider>(
                                  builder:
                                      (context, userProvider, child) =>
                                          ElevatedButton(
                                            onPressed:
                                                !isValidated ||
                                                        userProvider.isLoading
                                                    ? null
                                                    : () {
                                                        final UserProvider
                                                            authProvider =
                                                            context.read<
                                                                UserProvider>();

                                                        userProvider
                                                            .setIsLoading(true);

                                                        authProvider
                                                            .login(
                                                                email:
                                                                    _emailController
                                                                        .text,
                                                                password:
                                                                    _passwordController
                                                                        .text)
                                                            .then((response) {
                                                          userProvider
                                                              .setIsLoading(
                                                                  false);
                                                          if (response
                                                              is HingUser?) {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    kHomeRoute);
                                                          } else {
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                content: Text(response == HttpStatus.forbidden
                                                                    ? S.of(context).incorrectCredentials
                                                                    : response == HttpStatus.notFound
                                                                        ? S.of(context).thatAccountDoesntExists
                                                                        : response == 521
                                                                            ? S.of(context).serverIsUnavailable
                                                                            : response == SOCKET_EXCEPTION_CODE
                                                                                ? S.of(context).checkYourConnection
                                                                                : S.of(context).somethingWentWrong)));
                                                          }
                                                        });
                                                      },
                                            child: userProvider.isLoading
                                                ? const CircularIndicator()
                                                : Text(S.of(context).login),
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 24),
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    48)),
                                          )),
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
