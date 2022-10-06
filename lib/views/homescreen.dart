// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:io';
import 'package:api_app/AppConfig/Appconfig.dart';
import 'package:api_app/views/addproduct.dart';
import 'package:api_app/views/productlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? token;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String token = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.reload();
      token = pref.getString('token')!;
    });
  }

  Future<void> LogoutOfuser() async {
    var jsonResponse;

    Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/logout");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": 'Bearer $token'
      },
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body.toString());

      Navigator.pushNamed(context, '/');
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
            //automaticallyImplyLeading: false,
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('MENU', style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(8, 120, 93, 3),
                  ),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () {
                    LogoutOfuser();

                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Exit'),
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      exit(0);
                    });
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                  // MaterialButton(
                  //   onPressed: () {
                  //     _signOut();
                  //     Navigator.pushNamed(context, '/');
                  //   },
                  //   color: Colors.black.withOpacity(0.05),
                  //   textColor: Colors.white,
                  //   child: Text(
                  //     "SIGNOUT",
                  //     // style: GoogleFonts.droidSans(
                  //     //     fontSize: 20.0, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        readOnly: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          labelText: 'WELCOME USER $token', //$currentuseremail
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
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductList(token: token)));
                        Navigator.pushNamed(context, '/productlist');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Product List",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddProduct(token: token)));
                        Navigator.pushNamed(context, '/addproduct');
                        print(token);
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Add Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/editproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Edit Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/deleteproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Delete Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/singleproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Single Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
