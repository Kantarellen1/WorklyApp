import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final String apiBaseUrl = "http://localhost:5004/api/users"; // Update with your API base URL
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String registerResult = "";

  Future<void> registerUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: registerUser,
                child: const Text('Register'),
              ),
              const SizedBox(height: 10),
              Text(
                registerResult,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the login page
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}