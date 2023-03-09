import 'package:aishop_admin/navigation/locator.dart';
import 'package:aishop_admin/navigation/routing/route_names.dart';
import 'package:aishop_admin/provider/auth.dart';
import 'package:aishop_admin/services/navigation_service.dart';
import 'package:aishop_admin/styles/custom_text.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:aishop_admin/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static const lightblack = Color(0xFF181818);

  static const white = Color(0xFFFFFFFF);

  String email;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black87, Colors.grey[850]])),
      child: authProvider.status == Status.Authenticating
          ? Loading()
          : Scaffold(
              key: _key,
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          width: 350,
                          height: 400,
                          child: Image.asset(
                            'images/default.jpg',
                          ),
                        ),
                        Container(
                          height: 400,
                          child: VerticalDivider(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          height: 400,
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "LOGIN",
                                size: 22,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: authProvider.email,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                          icon: Icon(Icons.email_outlined)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      obscureText: true,
                                      controller: authProvider.password,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          icon: Icon(Icons.lock_open)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Alert(
                                              context: context,
                                              title:
                                                  "Enter email for password reset",
                                              content: Column(
                                                children: <Widget>[
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      labelText: 'E-mail',
                                                    ),
                                                    onChanged: (Email) {
                                                      email = Email;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () {
                                                    auth.sendPasswordResetEmail(
                                                        email: email);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Send email",
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 20),
                                                  ),
                                                  color: lightblack,
                                                ),
                                                DialogButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 20),
                                                  ),
                                                  color: lightblack,
                                                )
                                              ]).show();
                                        },
                                        child: CustomText(
                                          text: "Forgot password?",
                                          size: 16,
                                          color: Colors.grey,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (!await authProvider.signIn()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Login failed!")));
                                        return;
                                      }
                                      authProvider.clearController();

                                      locator<NavigationService>()
                                          .globalNavigateTo(
                                              LayoutRoute, context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "LOGIN",
                                            size: 22,
                                            color: Colors.white,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "Do not have an account? ",
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          locator<NavigationService>()
                                              .globalNavigateTo(
                                                  RegistrationRoute, context);
                                        },
                                        child: CustomText(
                                          text: "Sign up here. ",
                                          size: 16,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
    );
  }
}
