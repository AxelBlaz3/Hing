import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class UserItem extends StatefulWidget {
  const UserItem({Key? key}) : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/sample_post_image.jpg',
                  height: 48,
                  width: 48,
                )),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'Mike Goldberg',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            OutlinedButton(
              onPressed: () => {},
              child: Text(S.of(context).follow),
              // style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
              // //  style: Theme.of(context).textTheme.overline,
            )
          ],
        ));
  }
}
