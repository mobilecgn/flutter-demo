import 'package:flutter/material.dart';

import '../api/search.dart';
import 'login.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  SearchResult result = null;

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginForm()),
    );
  }

  void doSearch(String search) async {
    result = await UnsplashApi.search(search);
    setState(() {});
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
              keyboardType: TextInputType.text,
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
                doSearch(textInput);
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
        body: buildForm());
  }

  Widget buildForm() {
    if (result == null) {
      return Container();
    }
    return ImagesList(photos: result.results);
  }
}

class ImagesList extends StatelessWidget {
  final List<Photo> photos;

  ImagesList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(child: _buildList(context)),
      ],
    );
  }

  //Showing the images in listview
  ListView _buildList(context) {
    return new ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, int) {
          return Image.network(photos[int].smallUrl);
        });
  }
}
