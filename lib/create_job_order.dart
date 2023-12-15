import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tsk_sivil_app_new/complete_page2.dart';
import 'package:tsk_sivil_app_new/create_item_pipelog.dart';

class create_jo extends StatefulWidget {
  const create_jo({Key key}) : super(key: key);

  @override
  State<create_jo> createState() => _create_joState();
}

class _create_joState extends State<create_jo> {
  File uploadimage;
  bool isButtonActive = true;
  String remark = '';

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
      'data_tapping_item_id': dropdownvalue,
      'caption': dropdownvalue2,
      'remark': remark
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
        "https://1.9.118.25:8822/new-tsk-cp-erp/public/api/DataTappingItemId?id=widget.idDataTapping}";
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

  @override
  void initState() {
    super.initState();
    getAllCategory();
    getAllCategory2();
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  var dropdownvalue;
  var dropdownvalue2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job Order'),
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
                      'Project: name of project',
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
            Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Select DMA:'),
                    DropdownButton(
                      hint: Text('Select DMA'),
                      items: categoryItemlist.map((item) {
                        return DropdownMenuItem(
                          value: item['id'].toString(),
                          child: Text(item['nom_meter'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          dropdownvalue = newVal;
                        });
                      },
                      value: dropdownvalue,
                    ),
                    Text('Select Road Name:'),
                    DropdownButton(
                      hint: Text('Select Road Name'),
                      items: categoryItemlist2.map((item2) {
                        return DropdownMenuItem(
                          value: item2['id'].toString(),
                          child: Text(item2['caption'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          dropdownvalue2 = newVal;
                        });
                      },
                      value: dropdownvalue2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        /*padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),*/
                        onPressed: () async {
                          // var joDis = await joId.getPoId(widget.joDis);
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return create_pipelog(

                            );
                          }));
                        },
                        icon: Icon(Icons.save_alt),
                        label: Text("SAVE"),
                        //color: Color(0xFF186094),
                        //colorBrightness: Brightness.dark,
                      ),
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
