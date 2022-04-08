import 'package:chatapp/services/auth.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  // AuthMethods authMethods = new AuthMethods();

  final formkey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUP(){
    if(formkey.currentState!.validate()){
      setState(() {
        isLoading = true;
      });
      // authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
      //     passwordTextEditingController.text).then((val) => val
      //     // print("$val")
      // );
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                    .hasMatch(val!) ? null : "Please Provide a valid Email";
                              },
                              controller: emailTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("email"),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val){
                                return val!.length > 6 ?
                                null : "Please Provide Password (6-8 Characters)";
                              },
                              controller: passwordTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("password"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: simpleTextStyle(),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          signMeUP();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text("Sign Up", style: mediumTextStyle()),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text("Sign Up With Google",
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: mediumTextStyle(),
                          ),
                          const Text(
                            "Sign In Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ))));
  }
}
