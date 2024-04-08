import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';
import 'sms_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> _login(String username, String password) async {
    // You can implement your login logic here
    // For demo purposes, let's assume login is successful if username and password are not empty
    if (username.isNotEmpty && password.isNotEmpty) {
      // Save username in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);

      // Navigate to SMS Form page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SmsForm()),
      );
    } else {
      Fluttertoast.showToast(msg: 'Invalid username or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerUsername,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final username = _controllerUsername.text.trim();
                final password = _controllerPassword.text.trim();
                _login(username, password);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
