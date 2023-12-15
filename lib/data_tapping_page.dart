import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tsk_sivil_app_new/add_number_meter.dart';
import 'package:tsk_sivil_app_new/complete_page.dart';
import 'package:tsk_sivil_app_new/complete_page2.dart';
import 'package:tsk_sivil_app_new/dtcaptionData.dart';
import 'package:tsk_sivil_app_new/networking.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class data_tapping_page extends StatefulWidget {
  final joID;
  final idDataTapping;
  final sheetNo;
  final location;
  final username;

  data_tapping_page(
      {this.joID,
      this.idDataTapping,
      this.location,
      this.sheetNo,
      this.username});

  @override
  State<data_tapping_page> createState() => _data_tapping_pageState();
}

class _data_tapping_pageState extends State<data_tapping_page> {
  File uploadimage;
  bool isButtonActive = true;
  String remark = '';
  String joint_number = '';
  //String sopList = '';
  DTGallery dtGallery = DTGallery();

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  Future<void> chooseImageGallery() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  Future<void> uploadImage() async {
    //show your own loading or progressing code here

    //String uploadurl = "http://192.168.0.14/new-tsk-cp-dev/public/api/imageDataTappingItem";
    String uploadurl =
        "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/imageDataTappingItem";

    List<int> imageBytes = await uploadimage.readAsBytes();
    String baseimage = base64Encode(imageBytes);

    // /convert file image to Base64 encoding
    var response = await http.post(Uri.parse(uploadurl), body: {
      //'vehicle_id': widget.idVehicle.toString(),
      //'url': ,
      'image': baseimage,
      'photographer': widget.username.toString(),
      'jo_id': widget.joID.toString(),
      'data_tapping_item_id': dropdownvalue,
      'caption': dropdownvalue2,
      'remark': remark,
      'joint_number': joint_number
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

  /*WebViewController _webViewController;
  @override
  bool get wantKeepAlive => true;
  String _mySelection;

  final String url = "http://192.168.0.14/tsk-matic-erp/public/api/vehicles";

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }*/
  List categoryItemlist = [];

  Future getAllCategory() async {
    var baseUrl =
        "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/DataTappingItemId?id=${widget.idDataTapping}";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  List categoryItemlist2 = [];

  Future getAllCategory2() async {
    var baseUrl =
        "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/dataTappingCaption";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist2 = jsonData;
      });
    }
  }

  List categoryItemlist3 = [];

  Future<dynamic> getAllCategory3(int idDataTapping, String idItem) async {
    var baseUrl =
        "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/dti-gallery?data_tapping_id=$idDataTapping&data_tapping_item_id=$idItem";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist3 = jsonData;
      });
    }
    captionG = categoryItemlist3;
    print(baseUrl);
    print('ListCat:${categoryItemlist3}');
  }

  List categoryItemlist4;

  Future getAllCategory4(String idDataCaption) async {
    var baseUrl =
        "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/data_tap_cap_sop?data_caption_id=$idDataCaption";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist4 = jsonData;
      });
      //sopList = categoryItemlist4;
      print('List4: ${categoryItemlist4}');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCategory();
    getAllCategory2();
    getAllCategory4(dropdownvalue2);
    getAllCategory3(widget.idDataTapping, dropdownvalue);
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  var dropdownvalue;
  var dropdownvalue2;
  List captionG;
  var check;
  var sopDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Tapping Details'),
        backgroundColor: Color(0xFF9A0017),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sheet Number: ${widget.sheetNo}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Location: ${widget.location}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),

                    /*DropdownButton(
                      hint: Text('Select Details'),
                      items: data.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['item_name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _mySelection = newVal;
                        });
                      },
                      value: _mySelection,
                    )*/
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                /*padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),*/
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return add_no_meter(
                        joID: widget.joID,
                        idDataTapping: widget.idDataTapping,
                        sheetNo: widget.sheetNo,
                        location: widget.location,
                        username: widget.username);
                  })); // call choose image function
                },
                icon: Icon(Icons.add),
                label: Text("ADD NUMBER METER"),
                //color: Color(0xFF186094),
                //colorBrightness: Brightness.dark,
              ),
            ),
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
                    Text('Select Number Meter:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButton(
                      hint: Text('Select Number Meter'),
                      items: categoryItemlist.map((item) {
                        return DropdownMenuItem(
                          value: item['id'].toString(),
                          child: Text(item['nom_meter'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          dropdownvalue = newVal;
                           //Future<dynamic> getCiteWeather(${widget.idPipeLog}, dropdownvalue) async{
                           /*var url =
                               'https://1.9.118.25:8822/new-tsk-cp-erp/public/api/dti-gallery?data_tapping_id=${widget.idDataTapping}&data_tapping_item_id=$dropdownvalue';
                           NetworkHelper networkHelper = NetworkHelper(url);
                           var weatherData = await networkHelper.getData();
                           print(url);
                           captionG = weatherData;
                           print('captionPLI: ${captionG.length}');
                           return weatherData;*/
                          getAllCategory3(widget.idDataTapping, dropdownvalue);
                          //captionG = categoryItemlist3;
                          print('captionPLI: ${captionG.length}');
                        });
                      },
                      value: dropdownvalue,
                    ),
                    /*Container(
                      alignment: Alignment.center,
                      child: RaisedButton.icon(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        onPressed: () async {
                          check == 1;
                        },
                        icon: Icon(Icons.check_circle_outline),
                        label: Text("CHECK PICTURE LIST"),
                        color: Color(0xFF186094),
                        colorBrightness: Brightness.dark,
                      ),
                    ),*/
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'List of picture that has been taken.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    dropdownvalue == null?
                      Container()
                    :
                      SizedBox(
                        height: 70 * captionG.length.toDouble(),
                        child: ListView.builder(
                          padding: EdgeInsets.all(5.0),
                          itemCount: captionG?.length,
                          itemBuilder: (BuildContext context, int index) {
                            print('Length:${captionG?.length}');
                            return GestureDetector(
                              onTap: () async {},
                              child: Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                          child: Text(
                                            '${captionG[index]['data_tap_caption']['caption']}',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Select Caption:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButton(
                      hint: Text('Select Caption',
                      ),
                      items: categoryItemlist2.map((item2) {
                        return DropdownMenuItem(
                          value: item2['id'].toString(),
                          child: Text(item2['caption'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          dropdownvalue2 = newVal;
                          getAllCategory4(dropdownvalue2);

                          print('sopDetail : ${categoryItemlist4}');
                        });
                      },
                      value: dropdownvalue2,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Guideline for taking a picture:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    dropdownvalue2 == null ? Container():
                    Text('${categoryItemlist4.length > 0 ? categoryItemlist4[0]['sop'] : 'No SOP' }'),
                    SizedBox(
                      height: 25,
                    ),
                    dropdownvalue2 == '12'
                        ? Text('Joint Number:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),)
                        : Container(),
                    dropdownvalue2 == '12'
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
                    SizedBox(
                      height: 15,
                    ),
                    uploadimage == null ? Container() : Text('Remark:', style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    ),
                    Container(
                      //show upload button after choosing image
                      child: uploadimage == null
                          ? Container()
                          : //if uploadimage is null then show empty container
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 14),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter the Remark',
                                      errorStyle: TextStyle(color: Colors.red)),
                                  autofocus: true,
                                  onSaved: (value) => remark = value,
                                  onChanged: (value) {
                                    setState(() => remark = value);
                                  },
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        //show image here after choosing image
                        child: uploadimage == null
                            ? Container()
                            : //if uploadimage is null then show empty container
                            Container(
                                alignment: Alignment.center,
                                //elese show image here
                                child: SizedBox(
                                    height: 500,
                                    child: Image.file(
                                      uploadimage,
                                      fit: BoxFit.fill,
                                    ) //load image from file
                                    ))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        //show upload button after choosing image
                        child: uploadimage == null
                            ? Container()
                            : //if uploadimage is null then show empty container
                            Container(
                                alignment: Alignment.center,
                                //elese show uplaod button
                                child: ElevatedButton.icon(
                                  onPressed: isButtonActive
                                      ? () async {
                                          setState(
                                              () => isButtonActive = false);
                                          uploadImage();
                                          //messagePrint = 'Uploaded Successfully!';
                                          /*var deData = await _de.getDE(widget.url, donumberString );
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ViewDo(id: widget.id, num: widget.num, url: widget.url, de: deData); //hareylah. sabarlah nak balik pun
                            }));*/
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return completePage2(
                                                joID: widget.joID,
                                                idDataTapping:
                                                    widget.idDataTapping,
                                                location: widget.location,
                                                sheetNo: widget.sheetNo,
                                                username: widget
                                                    .username); //hareylah. sabarlah nak balik pun
                                          }));
                                          print('Detail: BEFORE DETAIL');
                                          //start uploading image
                                          //var deData = await _de.getDE(widget.url,widget.idVehicle);
                                          //print('Detail:${deData}');
                                          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ViewDo(id: widget.id, url: widget.url, idVehicle: widget.idVehicle, numReg: widget.numReg, detailImage: deData,); //hareylah. sabarlah nak balik pun
                        }));*/
                                        }
                                      : null,
                                  icon: Icon(Icons.file_upload),
                                  label: Text("UPLOAD IMAGE"),
                                  //color: Color(0xFF1565C0),
                                  //colorBrightness: Brightness.dark,
                                  //set brghtness to dark, because deepOrangeAccent is darker coler
                                  //so that its text color is light
                                ))),
                    SizedBox(
                      height: 10,
                    ),
                    uploadimage == null
                        ? Container(
                            alignment: Alignment.center,
                            child: ElevatedButton.icon(
                              /*padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),*/
                              onPressed: () async {
                                chooseImage(); // call choose image function
                              },
                              icon: Icon(Icons.camera_alt),
                              label: Text("ADD IMAGE"),
                              //color: Color(0xFF186094),
                              //colorBrightness: Brightness.dark,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    uploadimage == null
                        ? Container(
                            alignment: Alignment.center,
                            child: ElevatedButton.icon(
                              //padding: const EdgeInsets.symmetric(
                                //  horizontal: 30, vertical: 10),
                              onPressed: () async {
                                chooseImageGallery(); // call choose image function
                              },
                              icon: Icon(Icons.folder_open),
                              label: Text("SELECT IMAGE"),
                              //color: Color(0xFF186094),
                              //colorBrightness: Brightness.dark,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
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

/*
return WebView(
initialUrl: 'http://192.168.0.14:80/new-tsk-cp-dev/public/jobOrders/${widget.joID}',
javascriptMode: JavascriptMode.unrestricted,

onWebViewCreated: (controller) {_webViewController = controller;},
);*/
