import 'dart:async';

import 'package:finalyearproject/pages/chat_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/users.dart';

class SearchScreen extends StatefulWidget {
  Users user;
  SearchScreen(this.user);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    final databaseRef = FirebaseDatabase.instance.reference().child('users');
    databaseRef
        .orderByChild('name')
        .equalTo(searchController.text)
        .once()
        .then((DataSnapshot snapshot) {
          if (snapshot.value == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("No User Found")));
            setState(() {
              isLoading = false;
            });
            return;
          }

          Map<dynamic, dynamic>? data = snapshot.value as Map?;

          data!.forEach((key, value) {
            if (value['email'] != widget.user.email) {
              searchResult.add(value);
            }
          });

          setState(() {
            isLoading = false;
          });
        } as FutureOr Function(DatabaseEvent value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search your Friend"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "type username....",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          if (searchResult.length > 0)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(searchResult[index]['image']),
                        ),
                        title: Text(searchResult[index]['name']),
                        subtitle: Text(searchResult[index]['email']),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = "";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          currentUser: widget.user,
                                          friendId: searchResult[index]['uid'],
                                          friendName: searchResult[index]
                                              ['name'],
                                          friendImage: searchResult[index]
                                              ['image'])));
                            },
                            icon: Icon(Icons.message)),
                      );
                    }))
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
