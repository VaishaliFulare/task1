import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  List<User> _users = [];
  bool _isLoading = false;
  bool _hasError = false;
  bool _isGridView = false;
  int _page = 0;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isGridView => _isGridView;

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  Future<void> fetchUsers({bool reset = false}) async {
    if (reset) {
      _users.clear();
      _page = 0;
    }
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final newUsers = await _userService.fetchUsers(_page, 10);
      _users.addAll(newUsers);
      _page++;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
