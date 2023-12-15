import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class jobOrderDisplay extends StatefulWidget {
   final joDis;
   final joNum;
   final bqRoadId;

   jobOrderDisplay({this.joDis, this.joNum, this.bqRoadId});

   @override
   State<jobOrderDisplay> createState() => _jobOrderDisplayState();
 }

 class _jobOrderDisplayState extends State<jobOrderDisplay> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Job Order'),
       ),
       body: Container(
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
               'Job Order Number:''${widget.joNum}',
               style: TextStyle(
                 fontSize: 16.0,
                 color: Colors.black,
               ),
             ),
             Text(
               '${widget.bqRoadId}',
               style: TextStyle(
                 fontSize: 16.0,
                 color: Colors.black,
               ),
             ),
           ],
          ),
         ),
        ),
       ),
     );
   }
 }
