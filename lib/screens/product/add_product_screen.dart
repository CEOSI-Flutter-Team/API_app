// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:api_app/services/AuthServices.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/screens/home_screen.dart';

import '../../AppConfig/Appconfig.dart';

class add_product_screen extends StatefulWidget {
  add_product_screen({Key? key, String? token}) : super(key: key);

  @override
  _add_product_screenState createState() => _add_product_screenState();
}

class _add_product_screenState extends State<add_product_screen> {
  final _formKey2 = GlobalKey<FormState>();

  final imagelink_descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  void clearText() {
    imagelink_descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homescreen');
              },
              icon: Icon(Icons.arrow_back),
            ),
            centerTitle: true,
            title: Text('ADD PRODUCT'),
            backgroundColor: Colors.transparent,
          ),
          body: FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Container(
                key: _formKey2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        readOnly: false,
                        style: TextStyle(color: Colors.white),
                        controller: namecontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'press the box to get anon name';
                          }
                          return null;
                        },
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'your product name',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),

                          //when error has occured
                          errorStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: imagelink_descriptioncontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'password is required!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your description and imagelink',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          //when error has occured
                          // errorStyle: TextStyle(
                          //   color: Colors.red,
                          // ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: pricecontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'e-mail address is required.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your price',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          //when error has occured
                          // errorStyle: TextStyle(
                          //   color: Colors.red,
                          // ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        // controller: ispublishedcontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'password is required!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Is published?',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          //when error has occured
                          // errorStyle: TextStyle(
                          //   color: Colors.red,
                          // ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              // _launchURL3();
                            })
                      ],
                    ),
                    MaterialButton(
                      onPressed: () {
                        // if (_formKey2.currentState!.validate()) {
                        //addprod here
                        // if (namecontroller.text.isNotEmpty &&
                        //     imagelink_descriptioncontroller.text.isNotEmpty &&
                        //     pricecontroller.text.isNotEmpty) {
                        //   AuthServices().AddProduct(
                        //       namecontroller.text,
                        //       imagelink_descriptioncontroller.text,
                        //       imagelink_descriptioncontroller.text,
                        //       pricecontroller.text,
                        //       false);

                        //   Navigator.pushNamed(context, '/homescreen');
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text('Sucessfully Added product')));
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text('Incomplete Product details')));
                        // }
                        AuthServices(context).AddProduct(
                            namecontroller.text,
                            imagelink_descriptioncontroller.text,
                            imagelink_descriptioncontroller.text,
                            pricecontroller.text,
                            false);
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        'ADD',
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
