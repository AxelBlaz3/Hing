import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'John Daniel',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 4,
        ),
        ElevatedButton(
          onPressed: () => {},
          child: Text(S.of(context).follow),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
        )
      ],
    );
  }
}
