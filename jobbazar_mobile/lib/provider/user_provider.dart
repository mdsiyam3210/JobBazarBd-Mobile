import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/user.dart';
import 'package:jobbazar_mobile/provider/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _userService.getUsers();
    } catch (e) {
      _users = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
