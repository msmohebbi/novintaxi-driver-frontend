// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../backend/auth.dart';
import '../../providers/auth_data.dart';
import '../../providers/settings_data.dart';

// import 'package:http/http.dart' as htp;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  var name = TextEditingController();
  var username = TextEditingController();

  var nameNode = FocusNode();
  var usernameNode = FocusNode();
  bool isSigningUp = false;

  bool isSignUpPressed = false;

  final _formKey = GlobalKey<FormState>();

  String passwordErrorPhrase = "طول کلمه ی عبور نباید کمتر از 8 حرف باشد";

  String usernameErrorPhrase = "شماره موبایل معتبر وارد کنید";

  Future<void> signupUser() async {
    setState(() {
      isSignUpPressed = true;
    });
    if (isSigningUp ||
        !_formKey.currentState!.validate() ||
        username.text == "" ||
        name.text == "") {
      return;
    }
    usernameNode.unfocus();
    nameNode.unfocus();
    setState(() {
      isSigningUp = true;
    });
    try {
      var loginData =
          await Auth().signUp(name.text.trim(), username.text.trim());

      if (loginData["status"] == 201) {
        // await Provider.of<SettingData>(context, listen: false)
        //     .saveCredentials(loginData["refresh"]!, loginData["access"]!);
        await Provider.of<AuthData>(context, listen: false)
            .setUserTempPhone(username.text.trim());
        Provider.of<SettingData>(context, listen: false).setauthPageIndex(2);
      } else {
        String errorString = "خطا در ورود";
        if (loginData.toString().contains("username already exists")) {
          errorString = "کاربری با این شماره موبایل درحال حاضر وجود دارد";
        }
        if (loginData.toString().contains("too common")) {
          errorString = "پسورد بیش از اندازه آسان است";
        }
        if (loginData.toString().contains("entirely numeric")) {
          errorString = "پسورد باید حداقل شامل یک حرف انگلیسی باشد";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorString),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        setState(() {
          isSigningUp = false;
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("از اتصال دستگاه خود به اینترنت مطمئن شوید"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        isSigningUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthPixFixed = MediaQuery.of(context).size.width;
    var heightPixFixed = MediaQuery.of(context).size.height;
    var widthPix = widthPixFixed;
    var heightPix = heightPixFixed;
    if (widthPix > heightPix) {
      widthPix = heightPix;
    }
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: kToolbarHeight),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.5),
                    padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'نام و نام خانوادگی:',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kToolbarHeight * 0.2),
                        TextFormField(
                          focusNode: nameNode,
                          controller: name,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                r'^[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیئ]+',
                              ),
                            ),
                          ],
                          autovalidateMode: AutovalidateMode.always,
                          validator: (val) {
                            if (isSignUpPressed) {
                              try {
                                if ((val ?? "").length < 2) {
                                  return "نام و نام خانوادگی معتبر وارد کنید";
                                }
                              } catch (e) {
                                return "نام و نام خانوادگی معتبر وارد کنید";
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: kToolbarHeight * 0.3,
                              vertical: kToolbarHeight * 0.2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                strokeAlign: BorderSide.strokeAlignInside,
                                color: Theme.of(context).colorScheme.background,
                                width: 5,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Theme.of(context).hintColor,
                            hoverColor: Theme.of(context).cardColor,
                            // hintText: 'نام و نام خانوادگی',
                            // hintStyle: const TextStyle(
                            //   fontSize: 16,
                            // ),
                            hintTextDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kToolbarHeight * 0.3),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.5),
                    padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'شماره موبایل:',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kToolbarHeight * 0.2),
                        TextFormField(
                          controller: username,
                          focusNode: usernameNode,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            letterSpacing: 2,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              // ignore: unnecessary_string_escapes
                              RegExp("([A-Za-z0-9\_]+)"),
                            ),
                          ],
                          autovalidateMode: AutovalidateMode.always,
                          validator: (val) {
                            if (isSignUpPressed) {
                              try {
                                if ((val ?? "").length != 11 ||
                                    (val ?? "1")[0] != "0" ||
                                    (val ?? "00")[1] != "9") {
                                  return usernameErrorPhrase;
                                }
                              } catch (e) {
                                return usernameErrorPhrase;
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: kToolbarHeight * 0.3,
                              vertical: kToolbarHeight * 0.12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                strokeAlign: BorderSide.strokeAlignInside,
                                color: Theme.of(context).colorScheme.background,
                                width: 5,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Theme.of(context).hintColor,
                            hoverColor: Theme.of(context).cardColor,
                            hintText: "09** *** ****",
                            hintStyle: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                            hintTextDirection: TextDirection.ltr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kToolbarHeight),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.5),
                    child: Hero(
                      tag: "button",
                      child: InkWell(
                        onTap: signupUser,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              !isSigningUp
                                  ? Text(
                                      'ثبت نام',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 17,
                                      ),
                                    )
                                  : const CupertinoActivityIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kToolbarHeight * 0.3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "قبلا ثبت نام کرده اید؟ ",
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Provider.of<SettingData>(context, listen: false)
                              .changeIsLogin(true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                          child: Text(
                            "ورود",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: kToolbarHeight * 0.5),
            ],
          ),
        ),
      ),
    );
  }
}
