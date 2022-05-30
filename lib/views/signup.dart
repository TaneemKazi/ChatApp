// ignore_for_file: prefer_const_constructors

import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatRoomScreen.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  // const SignUp({Key? key}) : super(key: key);

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final formkey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp(){
    if(formkey.currentState!.validate()){

        Map<String, String> userInfoMap = {
          "name" : userNameTextEditingController.text,
          "email" : emailTextEditingController.text,
        };

      setState(() {
        isLoading = true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((val) {
            // print("${val.usersId}");

        databaseMethods.uploadUserInfo(userInfoMap);

            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => ChatRoom()
            ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: isLoading? Container(
          child: Center(
              child: CircularProgressIndicator()
          ),
        ) : SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height - 100,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                  ///Form Validation<!>
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val){
                                return val!.isEmpty || val.length < 4 ?
                                "Please Provide a valid User Name" : null;
                              },
                              controller: userNameTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("username"),
                            ),
                            TextFormField(
                              validator: (val){
                                return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!) ? null : "Please Provide a valid Email Address";
                              },
                              controller: emailTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("email"),
                            ),
                            TextFormField(
                              obscureText: true,//to make password invisible
                              validator: (val){
                                return val!.length > 6 ? null : "Please Provide Password (Atleast 6-8 Characters)";
                              },
                              controller: passwordTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("password"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                  ///Forgot Password?
                      Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: simpleTextStyle(),
                            ),
                          )),
                      SizedBox(
                        height: 8,
                      ),

                  ///SignUP for new user!
                      GestureDetector(
                        onTap: (){
                          signMeUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text("Sign Up", style: mediumTextStyle()),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text("Sign Up With Google",
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                  ///Existing User SignIn >>>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: mediumTextStyle(),
                          ),
                          GestureDetector(
                            onTap: (){
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Sign In Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ))));
  }
}
