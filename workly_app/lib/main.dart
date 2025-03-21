import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(UserServiceApp());
}

class UserServiceApp extends StatelessWidget {
  const UserServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Service Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserServiceHomePage(),
    );
  }
}

class UserServiceHomePage extends StatefulWidget {
  const UserServiceHomePage({super.key});

  @override
  _UserServiceHomePageState createState() => _UserServiceHomePageState();
}

class _UserServiceHomePageState extends State<UserServiceHomePage> {
  final String apiBaseUrl = "http://localhost:5004/api/users"; // Update with your API base URL
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController loginUsernameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  String registerResult = "";
  String loginResult = "";

  Future<void> registerUser() async {
    final password = registerPasswordController.text;
    final email = registerEmailController.text;

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'password': password, 'email': email}),
      );

      if (response.statusCode == 200) {
        setState(() {
          registerResult = "Registration successful!";
        });
      } else {
        final result = jsonDecode(response.body);
        setState(() {
          registerResult = "Error: ${result['message'] ?? 'Registration failed'}";
        });
      }
    } catch (e) {
      setState(() {
        registerResult = "Error: $e";
      });
    }
  }

  Future<void> loginUser() async {
    final username = loginUsernameController.text;
    final password = loginPasswordController.text;

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          loginResult = "Login successful! Token: ${result['token']}";
        });
      } else {
        final result = jsonDecode(response.body);
        setState(() {
          loginResult = "Error: ${result['message'] ?? 'Login failed'}";
        });
      }
    } catch (e) {
      setState(() {
        loginResult = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Service Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: registerEmailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: registerPasswordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: registerUser,
                child: Text('Register'),
              ),
              Text(registerResult, style: TextStyle(color: Colors.red)),

              SizedBox(height: 20),
              Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(
                controller: loginUsernameController,
                decoration: InputDecoration(labelText: 'Email or Username'),
              ),
              TextField(
                controller: loginPasswordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: loginUser,
                child: Text('Login'),
              ),
              Text(loginResult, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
