import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png', // Replace with your logo path
                height: 100, // Adjust height as needed
              ),
              const SizedBox(height: 24),
              const Text(
                'Sign in to SonarQube',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48), // Full width button
                ),
                child: const Text('Log In'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Handle forgot password logic here
                },
                child: const Text('Forgot password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
