// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twinzy/services/firebase/signup.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/space.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late FocusNode myFocusNode = FocusNode();
  int radioval = 0;
  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  bool ispass = true;
  bool ispass2 = true;

  void deleteField() {
    setState(() {
      firstNameController.clear();
      lastNameController.clear();
      phoneNumberController.clear();
      emailController.clear();
      passwordController.clear();
      conPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("signupPage")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: SizedBox(
                    width: 350,
                    height: 250,
                    child: Image.asset('assets/images/signupLogo.png'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.person),
                          labelText: translate("firstName"),
                        ),
                        validator: (val) {
                          return val!.isEmpty || val.length < 3
                              ? "Enter First Name 3+ characters"
                              : null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.person),
                          labelText: translate("lastName"),
                        ),
                        validator: (val) {
                          return val!.isEmpty || val.length < 3
                              ? "Enter Last Name 3+ characters"
                              : null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              spaceWidget(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: TextFormField(
                            controller: phoneNumberController,
                            focusNode: myFocusNode,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              alignLabelWithHint: true,
                              labelText: translate("phoneNumber"),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              return RegExp("^(07[789]-/d{7})").hasMatch(value!)
                                  ? null
                                  : "Please Enter Correct Phone";
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              spaceWidget(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                    labelText: translate("email"),
                  ),
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)
                        ? null
                        : "Please Enter Correct Email";
                  },
                ),
              ),
              spaceWidget(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: ispass,
                  keyboardType: TextInputType.visiblePassword,
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
                  validator: (value) => value!.length < 8
                      ? 'Your password must be equal or larger than 8 characters'
                      : null,
                ),
              ),
              spaceWidget(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: conPasswordController,
                  obscureText: ispass2,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: ispass2
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          ispass2 = !ispass2;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    labelText: translate("confirmPassword"),
                  ),
                  validator: (value) => value!.length < 8
                      ? 'Your password must be equal or larger than 8 characters'
                      : null,
                ),
              ),
              spaceWidget(height: 30),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(5)),
                    child: MaterialButton(
                      onPressed: () {
                        formKey.currentState!.validate();
                        if (conPasswordController.text ==
                                passwordController.text &&
                            formKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .where("phone",
                                  isEqualTo: phoneNumberController.text.trim())
                              .get()
                              .then((value) async {
                            if (value.docs.isEmpty) {
                              signUp(user: {
                                "firstName": firstNameController.text.trim(),
                                "lastName": lastNameController.text.trim(),
                                "phone": phoneNumberController.text.trim(),
                                "email": emailController.text.trim(),
                                "password": passwordController.text.trim()
                              }, context: context);
                              deleteField();
                            } else {
                              Fluttertoast.showToast(
                                  msg: translate('thisPhoneAlreadyExisted'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: primary,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        }
                      },
                      child: Text(
                        translate("signup"),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
              spaceWidget(height: 80),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(translate("alreadyHaveAnAccount?")),
                    spaceWidget(width: 3),
                    Text(
                      translate("login"),
                      style: const TextStyle(color: primary),
                    ),
                  ],
                ),
              ),
              spaceWidget(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
