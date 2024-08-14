import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/widgets/widgets.dart';
import '/loginpage.dart';
import '/widgets/colors.dart';
import '/widgets/textfields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'User.dart';
import 'after_login_go_to_this.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

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
      height: MediaQuery.of(context).size.height * 0.28,
    );
  }

  Widget mainUi(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.56,
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
            'در صورتی که هنوز عضو نشدید، ثبت نام کنید',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextFormFields(
              suffixIcon: Icons.person,
              hintText: 'نام کاربری (اجباری)',
              controller: usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: TextFormFields(
              suffixIcon: Icons.mail,
              hintText: 'ایمیل',
              controller: emailController,
            ),
          ),
          TextFormFields(
            suffixIcon: Icons.lock,
            hintText: 'رمز عبور(اجباری)',
            controller: passwordController,
            passwordcheck: true,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: TextFormFields(
              suffixIcon: Icons.lock,
              hintText: 'تکرار رمز عبور(اجباری)',
              controller: repasswordController,
              passwordcheck: true,
            ),
          ),
          const Text(
            "با عضویت در این برنامه قوانین ما\n"
            "را پذیرفته اید",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget footerUi(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.14,
        child: Column(
          children: [
            GradientButton(context, () {
              saveData();
            }, "عضویت"),
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
                            return Loginpage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "وارد شوید",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const Text(
                  'در صورتی که قبلا عضو شدید',
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

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final appUser = User(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      repassword: repasswordController.text,
    );
    if (passwordController.text != '' &&
        usernameController.text != '' &&
        passwordController.text == repasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlrtDialog(context, 'غیر فعال', 'در حال حاضر عضویت غیر فعال است \n لطفا با مشخصات پیش فرض وارد شوید');
        },
      );
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => AfterLoginGoToThis()));
    } else {
      if (usernameController.text == '' &&
          passwordController.text == '' &&
          repasswordController.text == '') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyAlrtDialog(
                context, 'خطای فیلد خالی', 'هیچ فیلد اجباری نباید خالی باشد');
          },
        );
      } else if (usernameController.text == '') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyAlrtDialog(
                context, 'خطای نام کاربری', 'نام کاربری نباید خالی باشد');
          },
        );
      } else if (passwordController.text != repasswordController.text) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyAlrtDialog(context, 'خطای رمز', 'رمز ها باید برابر باشند');
          },
        );
      }
    }

    String json = jsonEncode(appUser);
    debugPrint('created $json');
    prefs.setString('AppUser_key', json);
  }
}
