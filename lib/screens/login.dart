import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
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

  void login() {
    if (usernameController.text == "") {
      if (Platform.isIOS) {
        showErrorAlert("Username must not be empty");
        return;
      }
      showError("Username must not be empty");
      return;
    }
    if (passwordController.text == "") {
      showErrorAlert("Password must not be empty");
      return;
    }
    openNext();
  }

  void openNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", usernameController.text);
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

  void showErrorAlert(String error) {
    showPlatformDialog(title: new Text("Error"), content: new Text(error), actions: <Widget>[
      new FlatButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: new Text("OK"),
      ),
    ]);
  }

  Future<bool> showPlatformDialog({Widget title, Widget content, List<Widget> actions}) {
    Widget dialog;
    if (Platform.isAndroid) {
      dialog = AlertDialog(title: title, content: content, actions: actions);
    } else if (Platform.isIOS) {
      dialog = CupertinoAlertDialog(title: title, content: content, actions: actions);
    }
    return showDialog(context: context, builder: (context) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildiOS();
    }
    return buildAndroid();
  }

  Widget buildiOS() {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Color.fromRGBO(224, 31, 31, 1.0),
        ),
        child: SafeArea(
            top: false,
            bottom: false,
            child: Material(
              child: buildForm(),
            )));
  }

  Widget buildAndroid() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Builder(builder: (BuildContext innerContext) {
          _scaffoldContext = innerContext;
          return buildForm();
        }));
  }

  Widget buildForm() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                minWidth: 250.0,
                maxWidth: 450.0,
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
                            child: Image.asset(
                              'assets/mobilecgn_logo.png',
                              width: 200.0,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: usernameController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(labelText: "Username"),
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
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                              ),
                            ),
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
  }
}
