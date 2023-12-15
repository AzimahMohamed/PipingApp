
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tsk_sivil_app_new/main.dart';
import 'package:tsk_sivil_app_new/staff.dart';

class QRBarcodeScreen extends StatefulWidget {
  QRBarcodeScreen({this.url, this.url2});
  final url;
  final url2;

  @override
  _QrBarcodeState createState() => new _QrBarcodeState();
}

class _QrBarcodeState extends State<QRBarcodeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode mFocusNodeQrValue = FocusNode();
  TextEditingController qrController = new TextEditingController();
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;
  GlobalKey globalKey = new GlobalKey();
  String _qrInfo = 'Place QR Code in the scan area';
  Staff staff = Staff();
  Barcode result;
  QRViewController qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == 'intec-erp'){
      return new SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body:
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/card.jpg',
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 190,
                  ),
                  Center(
                    child: Text(
                      'Scan Your ID Card',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        _buildScan(context),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    }else if(widget.url == 'ame-erp'){
      return new SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body:
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/ame-card.jpg',
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 190,
                  ),
                  Center(
                    child: Text(
                      'Scan Your ID Card',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        _buildScan(context),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    }else{
      return new SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body:
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/tsk-card.jpg',
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 190,
                  ),
                  Center(
                    child: Text(
                      'Scan Your ID Card',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        _buildScan(context),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    }

  }

  @override
  void dispose() {
    mFocusNodeQrValue.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  Widget _buildScan(BuildContext context) {
    return Center(
      child: Container(
        //padding: const EdgeInsets.all(10.0),
        width: 350,
        height: 390,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 330,
                width: 340,
                margin: const EdgeInsets.only(bottom: 10),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController qrViewController) {
                    this.qrViewController = qrViewController;
                    qrViewController.scannedDataStream.listen((qrData) async {
                      qrViewController.pauseCamera();
                      final String qrCode = qrData.code;
                      var userData = await staff.getCiteWeather(widget.url, qrCode);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return UserFilterDemo(url: widget.url, user: userData); //hareylah. sabarlah nak balik pun
                      })).then((value) => qrViewController.resumeCamera());
                    });
                  },
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
              Text(
                _qrInfo,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
