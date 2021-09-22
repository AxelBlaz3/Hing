import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            S.of(context).editProfile,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        body: Stack(children: [
          Center(
              child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 96, top: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DottedBorder(
                  dashPattern: [8, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(16),
                  child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    width: 96,
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(S.of(context).name)),
                TextField(
                  decoration: InputDecoration(hintText: 'Jack123'),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(S.of(context).email)),
                TextField(
                  decoration: InputDecoration(hintText: 'abc@gmail.com'),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          )),
          SafeArea(
              child: Container(
                  margin: EdgeInsets.all(24),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(S.of(context).update),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      minimumSize: Size(MediaQuery.of(context).size.width, 48),
                    ),
                  )))
        ]));
  }
}
