import 'package:flutter/material.dart';
import 'package:hing/repository/user_repository.dart';

class AuthProvider extends ChangeNotifier {
  final UserRepository userRepository;

  AuthProvider({required this.userRepository});

  Future<dynamic> login({required String email, required String password}) async {
    return userRepository.login(email: email, password: password);
  }

  Future<dynamic> signup({required String email, required String displayName, required String password}) async {
    return userRepository.signup(email: email, password: password, displayName: displayName);
  }
}
