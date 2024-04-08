import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'login_page.dart'; // Import login page

class SmsForm extends StatelessWidget {
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();

  Future<void> _sendSms(String to, String message) async {
    final url = Uri.parse('http://your_server_address/send-sms?to=$to&message=$message');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'SMS sent successfully!');
      } else {
        Fluttertoast.showToast(msg: 'Failed to send SMS');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send SMS Notification'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate back to login page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerPhoneNumber,
              decoration: InputDecoration(
                labelText: 'Receiver Phone Number',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerMessage,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final phoneNumber = _controllerPhoneNumber.text.trim();
                final message = _controllerMessage.text.trim();

                if (phoneNumber.isNotEmpty && message.isNotEmpty) {
                  _sendSms(phoneNumber, message);
                } else {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                }
              },
              child: Text('Send SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
