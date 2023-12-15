import 'package:flutter/material.dart';
import 'package:tsk_sivil_app_new/constants.dart';
import 'package:tsk_sivil_app_new/decoration.dart';
import 'package:tsk_sivil_app_new/main.dart';
import 'package:tsk_sivil_app_new/scan_card_id.dart';

class landingPage extends StatefulWidget {
  final url;
  landingPage({this.url});

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF186094),
          elevation: 0.0,
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.menu,
                color: Color(0xFF000000),
              ),
              //onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        //backgroundColor: Color(0xFFFFFFFF),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child:
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(bottomLeft: 15, bottomRight: 15), boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),]
                ),
                height: 250,
                child:
                Column(
                  children: <Widget>[
                    Image.asset('assets/tsk-logo.png'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 180,
              child: Container(
                height: 380,
                width: MediaQuery.of(context).size.width - 50,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5
                      )
                    ]
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text('Project Piping',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Image.asset('assets/Frame.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.black,
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return UserFilterDemo(url: widget.url); //hareylah. sabarlah nak balik pun
                          }));
                        },
                        //colorBrightness: Brightness.dark,
                        //color: Colors.black,
                        child: Text(
                          'SCAN',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            /* Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('© INTEC PRECESION ENGINEERING SDN BHD'),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                )

            )*/
          ],
        ),
      ),
    );
  }
}
