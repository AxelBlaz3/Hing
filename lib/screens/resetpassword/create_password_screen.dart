import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String email;
  const CreatePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool obscureNewPasswordText = true;
  bool obscureConfirmPasswordText = true;
  bool isValidated = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _codeController.dispose();
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
                  onChanged: () {
                    setState(() {
                      isValidated = _formKey.currentState?.validate() ?? false;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
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
                        S.of(context).createNewPassword,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(S.of(context).resetPasswordHint),
                      SizedBox(height: 32),
                      TextFormField(
                        validator: (text) => text == null || text.isEmpty
                            ? S.of(context).codeIsEmpty
                            : null,
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: S.of(context).code,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: obscureNewPasswordText,
                        validator: (text) =>
                            text == null || text.isEmpty || text.length < 8
                                ? S
                                    .of(context)
                                    .passwordShouldContainAtleastEightChars
                                : null,
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                            hintText: S.of(context).newPassword,
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility_rounded,
                                  color: !obscureNewPasswordText
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureNewPasswordText =
                                        !obscureNewPasswordText;
                                  });
                                })),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: obscureConfirmPasswordText,
                        controller: _confirmPasswordController,
                        validator: (text) => text != _newPasswordController.text
                            ? S.of(context).passwordsMustMatch
                            : null,
                        decoration: InputDecoration(
                            hintText: S.of(context).confirmPassword,
                            suffixIcon: IconButton(
                                icon: Icon(Icons.visibility_rounded),
                                color: !obscureConfirmPasswordText
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    obscureConfirmPasswordText =
                                        !obscureConfirmPasswordText;
                                  });
                                })),
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
                              .createNewPassword(
                                  email: widget.email,
                                  password: _newPasswordController.text,
                                  code: _codeController.text)
                              .then((success) {
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(S.of(context).passwordUpdated)));
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  kLoginRoute, (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          S.of(context).somethingWentWrong)));
                            }
                          });
                        },
                  child: Text(S.of(context).resetPassword),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      minimumSize: Size(MediaQuery.of(context).size.width, 48)),
                ))),
      ],
    ));
  }
}
