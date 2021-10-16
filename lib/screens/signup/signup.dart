import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/circular_indicator.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isValidated = false;
  bool isTermsChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _displayNameController.dispose();
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
                  child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            'assets/logo.svg',
                            height: 48,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            S.of(context).createAnAccount,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          TextFormField(
                            validator: (text) => text == null || text.isEmpty
                                ? S.of(context).nameCannotBeEmpty
                                : null,
                            controller: _displayNameController,
                            decoration: InputDecoration(
                                hintText: S.of(context).displayName,
                                prefixIcon: IconButton(
                                    onPressed: null,
                                    icon: SvgPicture.asset(
                                      'assets/account_circle.svg',
                                    ))),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (text) => text == null || text.isEmpty
                                ? S.of(context).emailCannotBeEmpty
                                : !emailRegexPattern.hasMatch(text)
                                    ? S.of(context).enterAValidEmail
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
                            validator: (text) => text == null || text.length < 8
                                ? S.of(context).passwordMustBeAtLeast8Chars
                                : null,
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                                hintText: S.of(context).password,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
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
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isTermsChecked = !isTermsChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: isTermsChecked,
                                        onChanged: (newValue) {
                                          setState(() {
                                            isTermsChecked = !isTermsChecked;
                                          });
                                        }),
                                    Text(S.of(context).termsAndConditions)
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          Consumer<UserProvider>(
                              builder: (context, userProvider, child) =>
                                  ElevatedButton(
                                    onPressed: (!isValidated ||
                                            !isTermsChecked ||
                                            userProvider.isLoading)
                                        ? null
                                        : () {
                                            userProvider.setIsLoading(true);
                                            final UserProvider authProvider =
                                                context.read<UserProvider>();

                                            authProvider
                                                .signup(
                                                    email:
                                                        _emailController.text,
                                                    displayName:
                                                        _displayNameController
                                                            .text,
                                                    password:
                                                        _passwordController
                                                            .text)
                                                .then((response) {
                                              userProvider.setIsLoading(false);
                                              if (response is HingUser?) {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        kHomeRoute);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(response ==
                                                                HttpStatus.conflict
                                                            ? S
                                                                .of(context)
                                                                .emailNotAvailable
                                                            : response == SOCKET_EXCEPTION_CODE ? S.of(context).checkYourConnection : response == 521 ? S.of(context).serverIsUnavailable : S
                                                                .of(context)
                                                                .somethingWentWrong)));
                                              }
                                            });
                                          },
                                    child: userProvider.isLoading ? const CircularIndicator() : Text(S.of(context).createAccount),
                                    style: ElevatedButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 24),
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            48)),
                                  )),
                          SizedBox(
                            height: 16,
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.of(context)
                                  .pushReplacementNamed(kLoginRoute)
                            },
                            child: Text(S.of(context).alreadyhaveAnAccount),
                          ),
                        ],
                      ))))),
    ]));
  }
}
