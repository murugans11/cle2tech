import '../models/user_model.dart';
import 'dart:convert'; // Added for jsonEncode if actual HTTP call is used
import 'package:http/http.dart' as http; // Added for http.Client

// Abstract class definition
abstract class RemoteDataSource {
  Future<UserModel> login(String email, String password);
}

// Implementation class definition
class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  // TODO: Make baseUrl configurable
  final String _baseUrl = "https://api.example.com"; // Replace with a placeholder or actual API

  RemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate API call
    print("Attempting login for $email with password $password to $_baseUrl/login");

    // In a real scenario, you would make an HTTP POST request
    // For now, simulate a successful login after a delay
    await Future.delayed(Duration(seconds: 1));

    if (email == "test@example.com" && password == "password") {
      // Simulate a successful response
      return UserModel.fromJson({
        "id": "123",
        "name": "Test User",
        "email": "test@example.com"
      });
    } else {
      // Simulate an error response
      throw Exception('Login failed: Invalid credentials');
    }

    /*
    // Example actual HTTP call (once http dependency is added):
    final response = await client.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // Handle different error status codes appropriately
      throw Exception('Failed to login: ${response.statusCode} ${response.body}');
    }
    */
  }
}
