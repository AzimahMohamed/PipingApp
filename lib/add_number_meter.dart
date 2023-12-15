import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsk_sivil_app_new/data_tapping_page.dart';


class add_no_meter extends StatefulWidget {
  final joID;
  final idDataTapping;
  final sheetNo;
  final location;
  final username;

  add_no_meter({this.joID, this.idDataTapping, this.location, this.sheetNo, this.username});


  @override
  State<add_no_meter> createState() => _add_no_meterState();
}

class _add_no_meterState extends State<add_no_meter> {
  String typePipe = '';
  String sizePipe = '';
  String noMeter = '';
  String noRumah = '';
  bool isButtonActive = true;

  Future<void> uploadImage() async {
    //show your own loading or progressing code here

    //String uploadurl = "http://192.168.0.14/new-tsk-cp-dev/public/api/imageDataTappingItem";
    String uploadurl = "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/add_data_tap_item";

    // /convert file image to Base64 encoding
    var response = await http.post(Uri.parse(uploadurl), body: {
      //'vehicle_id': widget.idVehicle.toString(),
      //'url': ,
      'data_tapping_id': widget.idDataTapping.toString(),
      'pipe': typePipe,
      'size': sizePipe,
      'no_meter' : noMeter,
      'no_rumah': noRumah
    });
    print('Json: ${response.body}');
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body); //decode json data

    } else {
      print("Error during connection to server");
      //there is error during connecting to server,
      //status code might be 404 = url not found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Number Meter'),
        backgroundColor: Color(0xFF9A0017),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Enter type of pipe:'),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter type of pipe',
                              errorStyle: TextStyle(color: Colors.red)),
                          autofocus: true,
                          onSaved: (value) => typePipe = value,
                          onChanged: (value) {
                            setState(() => typePipe = value);
                          },
                        ),
                      ),
                    ),
                    Text('Enter size of pipe(mm):'),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter size of pipe(mm)',
                              errorStyle: TextStyle(color: Colors.red)),
                          autofocus: true,
                          onSaved: (value) => sizePipe = value,
                          onChanged: (value) {
                            setState(() => sizePipe = value);
                          },
                        ),
                      ),
                    ),
                    Text('Enter number meter:'),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter number meter',
                              errorStyle: TextStyle(color: Colors.red)),
                          autofocus: true,
                          onSaved: (value) => noMeter = value,
                          onChanged: (value) {
                            setState(() => noMeter = value);
                          },
                        ),
                      ),
                    ),
                    Text('Enter no rumah:'),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter no rumah',
                              errorStyle: TextStyle(color: Colors.red)),
                          autofocus: true,
                          onSaved: (value) => noRumah = value,
                          onChanged: (value) {
                            setState(() => noRumah = value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  //if uploadimage is null then show empty container
                        Container(
                            alignment: Alignment.center,
                            //elese show uplaod button
                            child: ElevatedButton.icon(
                              onPressed: isButtonActive ? () async {
                                setState(() => isButtonActive = false);
                                uploadImage();
                                //messagePrint = 'Uploaded Successfully!';
                                /*var deData = await _de.getDE(widget.url, donumberString );
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ViewDo(id: widget.id, num: widget.num, url: widget.url, de: deData); //hareylah. sabarlah nak balik pun
                            }));*/
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)  {
                                          return data_tapping_page(
                                              joID: widget.joID,
                                              idDataTapping: widget.idDataTapping,
                                              sheetNo:widget.sheetNo,
                                              location: widget.location,
                                              username: widget.username
                                          );
                                        }));
                                print('Detail: BEFORE DETAIL');
                                //start uploading image
                                //var deData = await _de.getDE(widget.url,widget.idVehicle);
                                //print('Detail:${deData}');
                                /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ViewDo(id: widget.id, url: widget.url, idVehicle: widget.idVehicle, numReg: widget.numReg, detailImage: deData,); //hareylah. sabarlah nak balik pun
                        }));*/
                              }  : null,
                              icon: Icon(Icons.file_upload),
                              label: Text("SAVE"),
                              //color: Color(0xFF1565C0),
                              //colorBrightness: Brightness.dark,
                              //set brghtness to dark, because deepOrangeAccent is darker coler
                              //so that its text color is light
                            )
                        )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
