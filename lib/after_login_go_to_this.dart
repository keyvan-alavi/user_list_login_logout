import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterLoginGoToThis extends StatefulWidget {
  const AfterLoginGoToThis({super.key});

  @override
  State<AfterLoginGoToThis> createState() => _AfterLoginGoToThisState();
}

class _AfterLoginGoToThisState extends State<AfterLoginGoToThis> {
  late String username;
  late String email;
  late String phone;
  late String fullname;

  @override
  void initState() {
    super.initState();
    UserInfo();
  }

  void UserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
      fullname = prefs.getString('fullname')!;
      phone = prefs.getString('phone')!;
      email = prefs.getString('email')!;
    });
  }

  void logOutOfPg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.setString('username', username);
    prefs.setString('fullname', fullname);
    prefs.setString('phone', phone);
    prefs.setString('email', email);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: Color.fromRGBO(21, 124, 202, 1.0),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.logout, color: Colors.white,), onPressed: logOutOfPg)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "hello $username",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "$fullname",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "$phone",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "$email",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
