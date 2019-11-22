import 'package:flutter/cupertino.dart';
import 'package:quest/Screens/VerificationScreen.dart';
import 'package:quest/constants.dart';
import 'package:flutter/material.dart';
import 'package:quest/Btn_resource.dart';
import 'login_screen.dart';
import 'package:string_validator/string_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'VerificationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "Registration";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _email;
  String _pass;
  int _currValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Sign Up",
            style: TextStyle(),
          ),
        ),
        backgroundColor: kMainColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Full Name',
                  ),
                  validator: (String arg) {
                    if (arg.length < 3)
                      return 'Name must be more than 2 charater';
                    else
                      return null;
                  },
                  onSaved: (String val) {
                    _name = val;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                        value: 0,
                        groupValue: _currValue,
                        onChanged: (value) {
                          setState(() {
                            _currValue = value;
                            //print(_currValue);
                          });
                        }),
                    Expanded(
                      child: Text(
                        "Student",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Radio(
                        value: 1,
                        groupValue: _currValue,
                        onChanged: (value) {
                          setState(() {
                            _currValue = value;
                            //print(_currValue);
                          });
                        }),
                    Expanded(
                      child: Text(
                        "Teacher",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Email",
                  ),
                  validator: (String value) {
                    if (!value.contains("@")) {
                      return "Invalid Email";
                    }
                    if (_currValue == 1) {
                      List<String> tEmail = value.split("@");
                      if (tEmail[1].compareTo("iiitvadodara.ac.in") == 0 ||
                          tEmail[1].compareTo("iiitv.ac.in") == 0) {
                        if (isNumeric(tEmail[0])) {
                          return "Teacher's Email Invalid";
                        } else {
                          return null;
                        }
                      } else
                        return "Teacher's Email Invalid";
                    } else {
                      List<String> sEmail = value.split("@");
                      if (sEmail[1].compareTo("iiitvadodara.ac.in") == 0 ||
                          sEmail[1].compareTo("iiitv.ac.in") == 0) {
                        if (isNumeric(sEmail[0])) {
                          return null;
                        } else {
                          return "Student's Email Invalid";
                        }
                      } else
                        return "Student's Email Invalid";
                    }
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Password",
                  ),
                  validator: (String val) {
                    if (val.isEmpty)
                      return "Please Enter Password";
                    else
                      return null;
                  },
                  onSaved: (value) {
                    _pass = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  btncolor: kMainColor,
                  btnText: 'Sign Up',
                  onPressed: _validateInputs,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have a account? ',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 15.0),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      final data = await _firestore
          .collection('signup')
          .where('email', isEqualTo: _email)
          .getDocuments();

      if (!data.documents.isEmpty) {
        print("Email Already exists");
      } else {
        _firestore.collection('signup').add({
          'name': _name,
          'pass': _pass,
          'email': _email,
          'type': _currValue
        });
      }

      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _pass);
        await newUser.sendEmailVerification();
//        Fluttertoast.showToast(
//          msg: "Complete the verification and sign In.",
//          toastLength: Toast.LENGTH_SHORT,
//        );
        if (newUser != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, VerifyScreen.id);
        }
      } catch (e) {
        print(e);
//        Fluttertoast.showToast(
//          msg: "The email address is already in use by another account.",
//          toastLength: Toast.LENGTH_SHORT,
//        );
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
