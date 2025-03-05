import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String baseUrl = 'https://dummyapi.io/data/v1/user';
  static const String appId = '666a92cbe42133bf4cdb3081';

  Future<List<User>> fetchUsers(int page, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl?limit=$limit&page=$page'),
      headers: {'app-id': appId},
    );

    if (response.statusCode == 200) {
      return User.fromJsonList(response.body);
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
