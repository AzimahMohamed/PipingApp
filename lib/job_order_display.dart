import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tsk_sivil_app_new/data_tapping.dart';
import 'package:tsk_sivil_app_new/data_tapping_page.dart';
import 'package:tsk_sivil_app_new/pipe_log_page.dart';

 class jobOrderDisplay extends StatefulWidget {
   final joDis;
   final joID;
   final joNum;
   final bqRoadId;
   final bqTitle;
   final pipeLog;
   final dataTapping;
   final username;

   jobOrderDisplay({this.joDis, this.joID, this.joNum, this.bqRoadId, this.bqTitle, this.pipeLog, this.dataTapping, this.username});

   @override
   State<jobOrderDisplay> createState() => _jobOrderDisplayState();
 }

 class _jobOrderDisplayState extends State<jobOrderDisplay> {
   Timer timer;
   int counter = 0;

   void incrementCounter() {
     setState(() {
       counter++;
     });
   }

   void decrementCounter() {
     setState(() {
       counter--;
     });
   }

   Widget row(String text, Color color) {
     return Padding(
       padding: EdgeInsets.all(12.5),
       child: Container(
         decoration: BoxDecoration(
           color: color,
           borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
         ),
         child: Center(
           child: Text(
             text,
             style: const TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
               fontSize: 12.5,
             ),
           ),
         ),
       ),
     );
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Job Order'),
         backgroundColor: Color(0xFF9A0017),
       ),
       body: Container(
         color: Color(0xFF186094),
         child: Column(
           children: <Widget>[
             Container(
               child: Card(
                 color: Colors.white10,
                 child: Padding(
                   padding: EdgeInsets.all(20.0),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text(
                         'Personal in Charge:''${widget.username}',
                         style: TextStyle(
                           fontSize: 16.0,
                           color: Colors.white,
                         ),
                       ),
                       Text(
                         'Job Order Number:''${widget.joNum}',
                         style: TextStyle(
                           fontSize: 16.0,
                           color: Colors.white,
                         ),
                       ),
                       Text(
                         'BoQ Road Name: ${widget.bqRoadId} || ${widget.bqTitle}',
                         style: TextStyle(
                           fontSize: 16.0,
                           color: Colors.white,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             widget.pipeLog == null ?
                 Container() :
             Container(
               height: 100,
               //flex: 5,
               child: SpringButton(
                 SpringButtonType.OnlyScale,
                 row(
                   "DETAILS PIPE LOG",
                   Colors.white,
                 ),
                 onTap: () async{Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context)  {
                           print('ID Pipelog: ${widget.pipeLog['id']}');
                           return pipe_log_page(
                               joID: widget.joID,
                               idPipeLog: widget.pipeLog['id'],
                               sheetNo:widget.pipeLog['sheet_no'],
                               location: widget.pipeLog['location'],
                               username: widget.username
                           );
                         }));},
                 onTapDown: (_) => incrementCounter(),
                 onLongPress: () => timer = Timer.periodic(
                   const Duration(milliseconds: 100),
                       (_) => incrementCounter(),
                 ),
                 onLongPressEnd: (_) {
                   timer?.cancel();
                 },
               ),
             ),
             widget.dataTapping == null ?
             Container() :
             Container(
               height: 100,
               //flex: 5,
               child: SpringButton(
                 SpringButtonType.OnlyScale,
                 row(
                   "DETAILS DATA TAPPING",
                   Colors.white,
                 ),
                 onTap: () async{Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context)  {
                           return data_tapping_page(
                               joID: widget.joID,
                               idDataTapping: widget.dataTapping['id'],
                               sheetNo:widget.dataTapping['sheet'],
                               location: widget.dataTapping['nama_jalan'],
                               username: widget.username
                           );
                         }));},
                 onTapDown: (_) => incrementCounter(),
                 onLongPress: () => timer = Timer.periodic(
                   const Duration(milliseconds: 100),
                       (_) => incrementCounter(),
                 ),
                 onLongPressEnd: (_) {
                   timer?.cancel();
                 },
               ),
             ),
             /*Container(
               height: 100,
               //flex: 5,
               child: SpringButton(
                 SpringButtonType.OnlyScale,
                 row(
                   "SITE DIARY",
                   Colors.deepPurpleAccent,
                 ),
                 onTap: () async{Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context)  {
                           return data_tapping_page(
                               joID: widget.joID,
                               sheetNo:widget.pipeLog['sheet_no'],
                               location: widget.pipeLog['location'],

                           );
                         }));},
                 onTapDown: (_) => incrementCounter(),
                 onLongPress: () => timer = Timer.periodic(
                   const Duration(milliseconds: 100),
                       (_) => incrementCounter(),
                 ),
                 onLongPressEnd: (_) {
                   timer?.cancel();
                 },
               ),
             ),*/
           ],
         ),
       )
     );
   }
 }
