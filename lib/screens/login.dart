import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/search.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Create the focus node. We will pass it to the TextField below.
  final FocusNode focusNode = FocusNode();
  final usernameController = TextEditingController(); // TextEditingController(text: 'info@thinkmobile.de');
  final passwordController = TextEditingController(); // TextEditingController(text: 'test1234');
  BuildContext _scaffoldContext;

  @override
  void dispose() {
    focusNode.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    setState(() {
      usernameController.text = username;
    });
  }

  void login() {}

  void openNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SearchForm()),
    );
  }

  void showError(String error) {
    Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
      content: new Text(error),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Builder(builder: (BuildContext innerContext) {
        _scaffoldContext = innerContext;
        return Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 150.0,
                    maxWidth: 250.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                    )),
                    child: Column(
                      children: <Widget>[
                        Form(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(labelText: "Benutzername"),
                                  onEditingComplete: () {},
                                  onFieldSubmitted: (String textInput) {
                                    FocusScope.of(context).requestFocus(focusNode);
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: passwordController,
                                  focusNode: focusNode,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.send,
                                  decoration: InputDecoration(labelText: "Password"),
                                  onFieldSubmitted: (value) {
                                    login();
                                  },
                                ),
                              ),
                              MaterialButton(
                                child: Text("Login"),
                                onPressed: () {
                                  login();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
