import 'package:app_note/models/iconbuttons.dart';
import 'package:app_note/styles/text.dart';
import 'package:flutter/material.dart';

class SearchBox extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [iconbutton(() => query = "", const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    iconbutton(() {
      close(context, null);
    }, const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Customtext(
        text: "Search History",
        size: 20,
      ),
    );
  }
}
