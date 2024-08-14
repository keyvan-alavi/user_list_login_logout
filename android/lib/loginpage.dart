import 'package:flutter/material.dart';
import 'package:myloginlogout/widgets/widgets.dart';
import 'package:myloginlogout/after_login_go_to_this.dart';
import 'package:myloginlogout/signuppage.dart';
import 'package:myloginlogout/widgets/colors.dart';
import 'package:myloginlogout/widgets/textfields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppUserList.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'nika'),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AppUI(context),
      ),
    );
  }

  Widget AppUI(BuildContext context) {
    return Container(
      decoration: PageColors(context),
      child: Column(
        children: [
          headerUi(context),
          mainUi(context),
          footerUi(context),
        ],
      ),
    );
  }

  Widget headerUi(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.32,
    );
  }

  Widget mainUi(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.53,
      child: Column(
        children: [
          const Text(
            "خوش آمدید",
            style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontFamily: 'samim',
                fontWeight: FontWeight.bold),
          ),
          const Text(
            'به اکانت خود وارد شوید',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormFields(
            suffixIcon: Icons.person,
            hintText: 'نام کاربری',
            controller: usernameController,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormFields(
            suffixIcon: Icons.lock,
            hintText: 'رمز عبور',
            passwordcheck: true,
            controller: passwordController,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
            child: Row(
              children: [
                const Text(
                  "فراموشی رمز عبور",
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                const Text(
                  "ذخیره مشخصات",
                  style: TextStyle(color: Colors.white),
                ),
                Checkbox(value: true, onChanged: (value) {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget footerUi(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          children: [
            GradientButton(context, () {
              loadData();
            }, "ورود"),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Signuppage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "عضو شوید",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const Text(
                  'هنوز عضو نشدید؟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            )
          ],
        ));
  }

  Future<void> loadData() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(Duration(milliseconds: 1), () {
        for (int id = 0; id < appUserList.length; id++) {
          if (usernameController.text == appUserList[id]["Username"] &&
              passwordController.text == appUserList[id]["Password"]) {
            String? username = appUserList[id]["Username"] as String?;
            String? password = appUserList[id]["Password"] as String?;
            String? email = appUserList[id]["Email"] as String?;
            String? fullname = appUserList[id]["FullName"] as String?;
            String? phone = appUserList[id]["PhoneNumber"] as String?;
            prefs.setBool('user', true);
            prefs.setString('username', username!);
            prefs.setString('password', password!);
            prefs.setString('email', email!);
            prefs.setString('phone', phone!);
            prefs.setString('fullname', fullname!);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AfterLoginGoToThis()));
          }
        }
      });
    } else if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlrtDialog(
              context, 'خطای فیلد خالی', 'هیچ فیلد اجباری نباید خالی باشد');
        },
      );
    }
  }
}
