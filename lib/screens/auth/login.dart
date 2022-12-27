// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/screens/auth/signup.dart';
import 'package:twinzy/services/changeLocal.dart';
import 'package:twinzy/services/firebase/login.dart';
import 'package:twinzy/services/navigation.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/buttom_bar.dart';
import 'package:twinzy/widgets/space.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool ispass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("loginPage")),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset('assets/images/loginLogo.png'),
                    ),
                  ),
                ),
                spaceWidget(height: 50),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                alignLabelWithHint: true,
                                labelText: translate("phoneNumber"),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                spaceWidget(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: passwordController,
                          obscureText: ispass,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: ispass
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  ispass = !ispass;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
                            labelText: translate("password"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spaceWidget(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: MaterialButton(
                            onPressed: () {
                              if (passwordController.text.isNotEmpty &&
                                  phoneNumberController.text.isNotEmpty) {
                                login(
                                    context: context,
                                    password: passwordController.text.trim(),
                                    phone: phoneNumberController.text.trim());
                              } else {
                                Fluttertoast.showToast(
                                    msg: translate('invalidEmailOrPassword'),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: primary,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text(
                              translate("login"),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                spaceWidget(height: 10),
                MaterialButton(
                  onPressed: () {
                    pushPage(context: context, pageName: const HomePage());
                  },
                  child: Text(
                    translate("skip"),
                    style: const TextStyle(color: primary, fontSize: 15),
                  ),
                ),
                spaceWidget(height: 80),
                InkWell(
                  onTap: () {
                    pushPage(context: context, pageName: const SignupPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(translate("newUser?")),
                      spaceWidget(width: 3),
                      Text(
                        translate("createAccount"),
                        style: const TextStyle(color: primary),
                      ),
                    ],
                  ),
                ),
                spaceWidget(height: 30),
              ],
            ),
            PopupMenuButton(
              icon: const Icon(Icons.language),
              padding: const EdgeInsets.only(left: 0, right: 0),
              splashRadius: 25,
              iconSize: 25,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  onTap: () {
                    setState(() {
                      localChange(setState: setState);
                      changeLocale(context, local);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translate('العربية')),
                      local == 'ar'
                          ? const Icon(
                              Icons.done,
                              color: primary,
                              size: 25,
                            )
                          : Container()
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    setState(() {
                      localChange(setState: setState);
                      changeLocale(context, local);
                      local == 'en';
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translate('English')),
                      local == 'en'
                          ? const Icon(
                              Icons.done,
                              color: primary,
                              size: 25,
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
