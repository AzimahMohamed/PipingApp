import 'package:flutter/material.dart';
import 'package:tsk_sivil_app_new/data_tapping_page.dart';
import 'package:tsk_sivil_app_new/decoration.dart';
import 'package:tsk_sivil_app_new/main.dart';
import 'package:tsk_sivil_app_new/pipe_log_page.dart';
import 'package:tsk_sivil_app_new/scan_card_id.dart';

class completePage2 extends StatefulWidget {
  final joID;
  final idDataTapping;
  final sheetNo;
  final location;
  final username;

  completePage2({this.joID, this.idDataTapping, this.location, this.sheetNo, this.username});

  @override
  _completePage2State createState() => _completePage2State();
}

class _completePage2State extends State<completePage2> {
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
                  child: Text('SUCCESSFULLY UPLOADED!',
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
                    Image.asset(
                      'assets/completed.png',
                      scale: 3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.black,
                      width: 165,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return data_tapping_page(
                                joID: widget.joID,
                                idDataTapping: widget.idDataTapping,
                                location: widget.location,
                                sheetNo: widget.sheetNo,
                                username: widget.username
                            ); //hareylah. sabarlah nak balik pun
                          }));
                        },
                        //colorBrightness: Brightness.dark,
                        //color: Colors.black,
                        child: Text(
                          'ADD OTHER IMAGE',
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
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return QRBarcodeScreen(); //hareylah. sabarlah nak balik pun
                              }));
                          /*var serviceData =
                              await vehicle.getVehicle(widget.url);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return QRBarcodeScreen(
                              url: widget.url,
                              //user: widget.id,
                              //service: serviceData,
                            );
                          }));*/
                          //var deData = await _de.getDE(widget.url, donumberString );
                          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return AfterPage(id: widget.id, url: widget.url); //hareylah. sabarlah nak balik pun
                          }));*/
                        },
                        //colorBrightness: Brightness.dark,
                        //color: Colors.black,
                        child: Text(
                          'HOME',
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
