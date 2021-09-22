import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  _HomeCategoriesState createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(S.of(context).categories)
      ],
    );
  }
}
