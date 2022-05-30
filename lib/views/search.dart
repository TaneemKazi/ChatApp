// ignore_for_file: prefer_const_constructors

import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  QuerySnapshot ? searchSnapshot;
  // JsonQuerySanpshot
  // @override
  // void initState() {
  //   searchSnapshot = "Flutter Campus";
  //   super.initState();
  // }

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val){
      print("Value");
      print(val.toString());
      setState(() {
        ///It Re-creates the whole screen with the updated data
        // searchSnapshot = val;
      });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot?.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTile(
            userName: searchSnapshot!.docs[index][String].data["name"],
            userEmail: searchSnapshot!.docs[index][String].data["email"],
          );
        }
        ) : Container();
  }

  // @override
  // void initState() {
  //   // setState(() {
  //   //   searchSnapshot == null;
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: searchTextEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Search UserName...",
                            hintStyle: TextStyle(
                              color: Colors.white54
                            ),
                            border: InputBorder.none
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        // databaseMethods.getUserByUsername(searchTextEditingController.text).then((val){
                        //   print(val.toString());
                        // });

                        initiateSearch();
                      },
                      child: Container(
                        height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: const [
                                  Color(0x36ffffff),
                                  Color(0x00ffffff),
                                ]
                            ),
                            borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child:
                          Image.asset("assets/images/search_white.png")),
                    )
                  ],
                ),
              ),
              searchList(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  // const SearchTile({Key? key}) : super(key: key);

  final String userName;
  final String userEmail;
  SearchTile({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Column(
            children: [
              Text(userName, style: simpleTextStyle(),),
              Text(userEmail, style: simpleTextStyle(),),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(13)
            ),

            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Message"),
          )
        ],
      ),
    );
  }
}

