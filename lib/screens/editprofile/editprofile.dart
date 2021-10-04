import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:hing/screens/editprofile/components/profile_placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final HingUser user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.user.displayName;
    _emailController.text = widget.user.email ?? '';

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(period: Duration(seconds: 2));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
  }

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
        body: WillPopScope(
            onWillPop: () {
              Provider.of<UserProvider>(context, listen: false)
                  .setEditProfileImage(null);
              return Future.value(true);
            },
            child: Stack(children: [
              Center(
                  child: SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 24, right: 24, bottom: 96, top: 24),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<UserProvider>(builder: (_, userProvider, __) {
                          final HingUser user =
                              Hive.box<HingUser>(kUserBox).get(kUserKey)!;

                          return GestureDetector(
                              onTap: () async {
                                final UserProvider userProvider =
                                    context.read<UserProvider>();

                                final XFile? image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                userProvider.setEditProfileImage(image);
                              },
                              child: Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, right: 8),
                                  child: widget.user.image == null &&
                                          userProvider.editProfileImage == null
                                      ? const ProfilePlaceholder()
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: userProvider
                                                      .editProfileImage !=
                                                  null
                                              ? Image.file(
                                                  File(userProvider
                                                      .editProfileImage!.path),
                                                  fit: BoxFit.cover,
                                                  height: 96,
                                                  width: 96,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      '$kBaseUrl/${user.image}',
                                                  fit: BoxFit.cover,
                                                  height: 96,
                                                  width: 96,
                                                  placeholder: (_, __) =>
                                                      const UserPlaceholder(
                                                    size: 32,
                                                  ),
                                                  errorWidget: (_, __, ___) =>
                                                      const UserPlaceholder(
                                                    size: 32,
                                                  ),
                                                )),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.edit_rounded,
                                            size: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)))
                              ]));
                        }),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          S.of(context).uploadPhoto,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(S.of(context).name)),
                        TextFormField(
                          controller: _nameController,
                          validator: (text) => text == null || text.isEmpty
                              ? S.of(context).nameCannotBeEmpty
                              : null,
                          decoration: InputDecoration(hintText: 'Jack'),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(S.of(context).email)),
                        TextFormField(
                          controller: _emailController,
                          validator: (text) => text == null || text.isEmpty
                              ? S.of(context).emailCannotBeEmpty
                              : null,
                          decoration:
                              InputDecoration(hintText: 'jack@gmail.com'),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    )),
              )),
              SafeArea(
                  child: Container(
                      margin: EdgeInsets.all(24),
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          final bool isValidated =
                              _formKey.currentState?.validate() ?? false;
                          if (!isValidated) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(S.of(context).fixErrorsAbove)));
                            return;
                          }

                          final UserProvider userProvider =
                              context.read<UserProvider>();
                          userProvider
                              .updateUser(
                                  displayName: _nameController.text,
                                  email: _emailController.text,
                                  image: userProvider.editProfileImage)
                              .then((success) {
                            if (success) {
                              // Notify about user update
                              context.read<UserProvider>().notifyUserChanges();
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(S.of(context).profileUpdated)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          S.of(context).somethingWentWrong)));
                            }
                          });
                        },
                        child: Text(S.of(context).update),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 48),
                        ),
                      )))
            ])));
  }
}
