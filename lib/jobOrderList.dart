import 'package:flutter/material.dart';
import 'package:tsk_sivil_app_new/job_order_display.dart';
import 'package:tsk_sivil_app_new/joborderdata.dart';
// import 'package:tsk_sivil_app_new/services.dart';

import 'job_order.dart';
import 'main.dart';



class jobOrderList extends StatefulWidget {
  final joData;

  jobOrderList({this.joData});


  @override
  State<jobOrderList> createState() => _jobOrderListState();
}

class _jobOrderListState extends State<jobOrderList> {
  List<JobOrder> filteredJobOrders = List();
  // PO joId = PO();
  // get joId => null;

  final _debouncer = Debouncer(milliseconds: 500);
  List<JobOrder> jo = List();
  List<JobOrder> filteredJobs = List();
  PO joId = PO();

  var joDis;

  List<JobOrder> get joFromServer => null;
  

  @override
  void initState() {
    super.initState();
      setState(() {
        jo = joFromServer;
        filteredJobOrders = jo;
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Job Order List'),
        backgroundColor: Colors.blueAccent[100],
      ),

      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: widget.joData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async{
                      // var joDis = await joId.getPoId(widget.joDis);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)  {
                                return jobOrderDisplay(joDis: widget.joData, joNum: widget.joData[index]['jo_number'], bqRoadId: widget.joData[index]['bq_road_id']);
                    }));
                    
                      print("joDis: ${joDis}");
                    },
                    child: Card(
                      color: Colors.yellow.shade300,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.joData[index]['jo_number'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
      ,
    );
  }
}
