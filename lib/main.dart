import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsk_sivil_app_new/base_url.dart';
import 'package:tsk_sivil_app_new/jobOrderList.dart';
import 'package:tsk_sivil_app_new/job_order.dart';
import 'package:tsk_sivil_app_new/landing_page.dart';
import 'package:tsk_sivil_app_new/services.dart';
import 'package:tsk_sivil_app_new/sub_project.dart';
import 'User.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}

Future main() async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) {
    final isValidHost = host == "http://192.168.0.14/tsk-cp-erp/public/api/civil/wo/upload-image";
    return isValidHost;
  });
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({this.url});
  final url;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String urlBase;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      urlBase = prefs.getString('urlBase');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: urlBase == null ?
        AnimatedSplashScreen(
          splashIconSize: 250,
          splash: Image.asset('assets/logo.png'),
          nextScreen:  Basedurl(url: urlBase,),
          backgroundColor:  Color(0xFFFFFFFF),
        )
            :
        AnimatedSplashScreen(
          splashIconSize: 250,
          splash: Image.asset('assets/logo.png'),
          nextScreen:  landingPage(url: urlBase,),
          backgroundColor:  Color(0xFFFFFFFF),
        )

    );
  }
}

class UserFilterDemo extends StatefulWidget {
  final url;
  final user;
  UserFilterDemo({this.url, this.user});

  final String title = "LIST OF MAIN PROJECT";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<UserFilterDemo> {
  // https://jsonplaceholder.typicode.com/users

  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = List();
  List<User> filteredUsers = List();
  PO joId = PO();

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Color(0xFF000000)),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/test.png"),
              fit: BoxFit.fitWidth
          ),
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Filter by project name',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    filteredUsers = users
                        .where((u) => (u.name
                        .toLowerCase()
                        .contains(string.toLowerCase())))
                        .toList();
                  });
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async{
                      var joData = await joId.getPoId(filteredUsers[index].id);
                      //var doData = await doId.getDoId(filteredUsers[index].id);
                      // print("doData: ${doData}");
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return jobOrderList(joData: joData,); //hareylah. sabarlah nak balik pun
                      }));
                      print("joData: ${joData}");
                    },
                    child: Card(
                      color: Colors.yellow.shade200,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              filteredUsers[index].name,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}