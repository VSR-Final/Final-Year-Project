import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform login
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to sign up page
              },
              child: Text('Sign up'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to forgot password page
              },
              child: Text('Forgot password'),
            ),
          ],
        ),
      ),
    );
  }
}
