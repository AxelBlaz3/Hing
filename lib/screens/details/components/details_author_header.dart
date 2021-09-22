import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/home/components/feed_item_profile.dart';

class DetailsAuthorHeader extends StatefulWidget {
  final Recipe recipe;
  const DetailsAuthorHeader({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsAuthorHeaderState createState() => _DetailsAuthorHeaderState();
}

class _DetailsAuthorHeaderState extends State<DetailsAuthorHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Row(
          children: [
            Expanded(child: FeedItemProfile(recipe: widget.recipe,)),
            widget.recipe.user.isFollowing ?? false ? 
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                S.of(context).unfollow,
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              ),
            )
            :
            ElevatedButton(
              onPressed: () => {},
              child: Text(
                S.of(context).follow,
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              ),
            )
          ],
        ));
  }
}
