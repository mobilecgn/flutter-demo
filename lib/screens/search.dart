import 'package:flutter/material.dart';

import 'login.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            padding: EdgeInsets.only(right: 50.0, top: 25.0, left: 20.0),
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white)),
              onEditingComplete: () {},
              onFieldSubmitted: (String textInput) {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: "Logout",
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        body: Builder(builder: (BuildContext innerContext) {
          return buildForm();
        }));
  }

  Widget buildForm() {
    return Container();
  }
}
