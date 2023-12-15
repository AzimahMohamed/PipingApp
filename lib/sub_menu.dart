import 'package:flutter/material.dart';
import 'package:tsk_sivil_app_new/decoration.dart';
import 'package:tsk_sivil_app_new/hero.dart';
import 'package:tsk_sivil_app_new/jobOrderList.dart';

class submenuPage extends StatefulWidget {
  submenuPage({this.joData, this.id,});

  final joData;
  final id;

  @override
  _submenuPageState createState() => _submenuPageState();
}

class _submenuPageState extends State<submenuPage> {
  //deAPI _de = deAPI();
  //String donumberString;

  /*Future<void>updateUI(dynamic userData, staffData) {
    if (userData['status'] == 1) {
      setState(() {
        donumberString = "${userData['deliveryorder']['id']}";
      });
    }else{
      setState(() {
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    //updateUI(widget.num, widget.id);
    //print('id:${widget.num}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radiusOnly(bottomLeft: 15, bottomRight: 15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                height: 250,
                child: Center(
                  child: Text('MAIN MENU',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                height: 395,
                width: MediaQuery.of(context).size.width - 50,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5)
                    ]),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Hero(
                        tag: Text('hero-rectangle'),
                        child: BoxWidget(
                            size: Size(200.0, 200.0)
                        ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.black,
                      width: 165,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                        },
                        //colorBrightness: Brightness.dark,
                        //color: Colors.black,
                        child: Text(
                          'SITE DIARY',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*Container(
                      color: Colors.black,
                      width: 165,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () async {
                          //var deData = await _de.getDE(widget.url, donumberString );
                          */ /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ViewDo(id: widget.id, num: widget.num, url: widget.url, de: deData); //hareylah. sabarlah nak balik pun
                          }));*/ /*
                        },
                        colorBrightness: Brightness.dark,
                        color: Colors.black,
                        child: Text(
                          'VIEW DO DETAIL',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/
                    Container(
                      color: Colors.black,
                      width: 165,
                      height: 40,
                      child: TextButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //return completePage(joData: joData,id: widget.user['staff']['name']);
                            return jobOrderList(joData: widget.joData,id: widget.id); //hareylah. sabarlah nak balik pun
                          }));
                        },
                        //colorBrightness: Brightness.dark,
                        //color: Colors.black,
                        child: Text(
                          'JOB ORDER',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
