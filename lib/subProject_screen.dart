import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class TestDetailPage extends StatefulWidget {
  final List<dynamic> link;
  final url;
  final user;
  TestDetailPage(this.link, this.url,this.user);

  @override
  _TestDetailPageState createState() => _TestDetailPageState();
}

class _TestDetailPageState extends State<TestDetailPage> {

  File uploadimage;

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('List Widget: ${widget.link}');
  }

  @override
  Widget build(BuildContext context) {
  }
}

