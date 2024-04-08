import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> _register(String firstName, String lastName, String username, String email, String phone, String password) async {
    final url = Uri.parse('http://your_server_address/register');
    final response = await http.post(url, body: {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'User registered successfully');
      // Navigate to login page
    } else {
      Fluttertoast.showToast(msg: 'Failed to register user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerFirstName,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerLastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerUsername,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerPhone,
              decoration: InputDecoration(
                labelText: 'Phone',
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
                final firstName = _controllerFirstName.text.trim();
                final lastName = _controllerLastName.text.trim();
                final username = _controllerUsername.text.trim();
                final email = _controllerEmail.text.trim();
                final phone = _controllerPhone.text.trim();
                final password = _controllerPassword.text.trim();
                _register(firstName, lastName, username, email, phone, password);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
