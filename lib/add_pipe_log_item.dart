import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsk_sivil_app_new/data_tapping_page.dart';


class add_pipe_log_item extends StatefulWidget {



  @override
  State<add_pipe_log_item> createState() => _add_pipe_log_itemState();
}

class _add_pipe_log_itemState extends State<add_pipe_log_item> {
  String typePipe = '';
  String sizePipe = '';
  String noMeter = '';
  String noRumah = '';
  bool isButtonActive = true;
  String joint_number = '';


  Future<void> uploadImage() async {
    //show your own loading or progressing code here

    //String uploadurl = "http://192.168.0.14/new-tsk-cp-dev/public/api/imageDataTappingItem";
    String uploadurl = "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/add_data_tap_item";

    // /convert file image to Base64 encoding
    var response = await http.post(Uri.parse(uploadurl), body: {
      //'vehicle_id': widget.idVehicle.toString(),
      //'url': ,
      //'data_tapping_id': widget.idDataTapping.toString(),
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

  List categoryItemlist = [];

  Future getAllCategory() async {
    var baseUrl = "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/pl-attribute-list";

    //var baseUrl = "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/PipeLogItemId?id=${widget.idPipeLog}";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCategory();
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  var dropdownvalue;
  var dropdownvalue2;
  List captionG;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pipe Log Item'),
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
                    Text('Select Attribute in PipeLog:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButton(
                      hint: Text('Select Attribute'),
                      items: categoryItemlist.map((item) {
                        return DropdownMenuItem(
                          value: item['id'].toString(),
                          child: Text(item['attribute'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          dropdownvalue = newVal;
                          //Future<dynamic> getCiteWeather(${widget.idPipeLog}, dropdownvalue) async{
                          /*var url = 'https://1.9.118.25:8822/new-tsk-cp-erp/public/api/pli-gallery?pipe_log_id=${widget.idPipeLog}&pipe_log_item_id=$dropdownvalue';
                            NetworkHelper networkHelper = NetworkHelper(url);
                            var weatherData = await networkHelper.getData();
                            print(url);
                            captionG = weatherData;
                          print('captionPLI: ${captionG}');
                            return weatherData;*/
                          //var captionPLI = await getCiteWeather(widget.idPipeLog, dropdownvalue);
                          //captionG = captionPLI;
                          //print('captionPLI: ${captionG}');
                          //print("TestList${categoryItemlist3}");
                          //captionG = categoryItemlist3;
                          //getAllCategory3(widget.idPipeLog, dropdownvalue);
                          print("Dropdown Value id: ${dropdownvalue}");
                          //print("Length Caption: ${captionG.length}");

                          //return categoryItemlist3;
                        });
                        print("Dropdown Value id luar: ${dropdownvalue}");
                      },
                      value: dropdownvalue,
                    ),

                    dropdownvalue == '1' ?
                    Text('Enter CHAINAGE:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),)
                        : Container(),
                    dropdownvalue == '12'
                        ? Text('Joint Number:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),)
                        : Container(),
                    dropdownvalue == '12'
                        ? Container(
                      //show upload button after choosing image
                      child: //if uploadimage is null then show empty container
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 14),
                          child: TextFormField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter the Joint Number',
                                errorStyle: TextStyle(color: Colors.red)),
                            autofocus: true,
                            onSaved: (value) => joint_number = value,
                            onChanged: (value) {
                              setState(() => joint_number = value);
                            },
                          ),
                        ),
                      ),
                    )
                        : Container(),
                    Text('Enter quantity:'),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 14),
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter quantity',
                              errorStyle: TextStyle(color: Colors.red)),
                          autofocus: true,
                          onSaved: (value) => sizePipe = value,
                          onChanged: (value) {
                            setState(() => sizePipe = value);
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
