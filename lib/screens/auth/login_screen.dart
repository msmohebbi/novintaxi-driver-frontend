// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../backend/auth.dart';
import '../../providers/auth_data.dart';
import '../../providers/settings_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var username = TextEditingController();
  var usernameNode = FocusNode();
  bool isLoginPressed = false;
  bool isLogingIn = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    setState(() {
      isLoginPressed = true;
    });
    if (!_formKey.currentState!.validate() ||
        isLogingIn ||
        username.text == "") {
      return;
    }
    usernameNode.unfocus();
    setState(() {
      isLogingIn = true;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    String errorString = "مشکلی پیش آمده است لظفا مجدد تلاش کنید";
    try {
      var lastPassSent =
          Provider.of<AuthData>(context, listen: false).lastSmsSend;
      bool isrequestedPass = true;
      var nowDateTime = DateTime.now().millisecondsSinceEpoch;
      if (lastPassSent + (60 * 1000) < nowDateTime) {
        isrequestedPass = await Auth().requestPass(username.text.trim());
        if (isrequestedPass) {
          await Provider.of<AuthData>(context, listen: false)
              .setLastSmsSend(DateTime.now().millisecondsSinceEpoch);
          await Provider.of<AuthData>(context, listen: false)
              .setUserTempPhone(username.text.trim());
          Provider.of<SettingData>(context, listen: false).setauthPageIndex(2);

          return;
        } else {
          errorString = "کاربری با شماره موبایل وارد شده موجود نمی باشد";
        }
      } else {
        errorString = "لطفا پس از یک دقیقه مجدد تلاش کنید";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorString),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (errr) {
      log(errr.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("از اتصال دستگاه خود به اینترنت مطمئن شوید"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }

    setState(() {
      isLogingIn = false;
    });
  }

  String usernameErrorPhrase = "شماره موبایل معتبر وارد کنید";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                                'شماره موبایل:',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: kToolbarHeight * 0.2),
                          TextFormField(
                            focusNode: usernameNode,
                            controller: username,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  // ignore: unnecessary_string_escapes
                                  RegExp("([A-Za-z0-9\_]+)"))
                            ],
                            autovalidateMode: AutovalidateMode.always,
                            validator: (val) {
                              if (isLoginPressed) {
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
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              // focusColor: Theme.of(context).cardColor,
                              // hoverColor: Theme.of(context).cardColor,
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
                const SizedBox(height: kToolbarHeight * 2),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kToolbarHeight * 0.5),
                      child: Hero(
                        tag: "button",
                        child: InkWell(
                          onTap: loginUser,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !isLogingIn
                                    ? Text(
                                        'ورود',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 17,
                                        ),
                                      )
                                    : CupertinoActivityIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
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
                          "تاکنون ثبت نام نکرده اید؟ ",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Provider.of<SettingData>(context, listen: false)
                                .changeIsLogin(false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                            child: Text(
                              "ثبت نام",
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
      ),
    );
  }
}
