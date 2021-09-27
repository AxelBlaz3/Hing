import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).createAnAccount,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextField(controller: _displayNameController,
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
                      TextField(
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
                      TextField(
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
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () => {},
                            child: Row(
                              children: [
                                Checkbox(
                                    value: false, onChanged: (newValue) => {}),
                                Text(S.of(context).termsAndConditions)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final UserProvider authProvider =
                                  context.read<UserProvider>();

                          authProvider
                              .signup(
                                  email: _emailController.text,
                                  displayName: _displayNameController.text,
                                  password: _passwordController.text)
                              .then((response) => (response is HingUser?)
                                  ? Navigator.of(context)
                                      .pushReplacementNamed(kHomeRoute)
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(response == 409 ? S.of(context).emailNotAvailable : S.of(context).somethingWentWrong))));
                        },
                        child: Text(S.of(context).createAccount),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 48)),
                      ),
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
                  )))),
    ]));
  }
}
