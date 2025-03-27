import 'package:flutter/material.dart';
import 'mainPage.dart'; // Import the MainPage
import 'register.dart'; // Import the RegisterPage

void main() {
  runApp(const UserServiceApp());
}

class UserServiceApp extends StatelessWidget {
  const UserServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Service Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginUsernameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  String loginResult = "";

  @override
  void initState() {
    super.initState();
    // Pre-fill admin credentials for testing
    loginUsernameController.text = "admin@example.com"; // Admin username
    loginPasswordController.text = "admin123"; // Admin password
  }

  Future<void> loginUser() async {
    final username = loginUsernameController.text;
    final password = loginPasswordController.text;

    // Hardcoded admin credentials
    const hardcodedUsername = "admin@example.com";
    const hardcodedPassword = "admin123";

    // Simulate login logic
    if (username == hardcodedUsername && password == hardcodedPassword) {
      setState(() {
        loginResult = "Login successful!";
      });

      // Navigate to MainPage on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      setState(() {
        loginResult = "Error: Invalid username or password.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: loginUsernameController,
                  decoration: const InputDecoration(labelText: 'Email or Username'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginPasswordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: loginUser,
                  child: const Text('Login'),
                ),
                Text(loginResult, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text('Go to Register Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
