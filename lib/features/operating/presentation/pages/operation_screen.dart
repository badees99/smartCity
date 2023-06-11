import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/event.dart';

class OperationPage extends StatefulWidget {
  final Bin bin;

  const OperationPage({Key? key, required this.bin}) : super(key: key);

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  String status = '' ;
  @override
  void initState() {
    status = widget.bin.status ; 
    FirebaseFirestore.instance
        .collection('Bins')
        .doc(widget.bin.id)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data != null && data['status'] != null && double.parse(data['status'].toString()) <25 ) {
        // Update the state of your application here based on the updated data
        setState(() {
          // Example state update:
          status = data['status'].toString();
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operation'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DustBin ID: ${widget.bin.id}',
                style: TextStyle(fontSize: 28.sp),
              ),
              const Padding(padding: EdgeInsets.all(20.0)),
              Text('status ${status}%', style: TextStyle(fontSize: 16.sp)),
              const Padding(padding: EdgeInsets.all(20.0)),
              Center(
                child: Column(
                  children: [
                    Text('Waiting for collection',
                        style: TextStyle(fontSize: 16.sp)),
                    Padding(padding: EdgeInsets.all(20.0)),
                    double.parse(status) > 25 ? CircularProgressIndicator() :
                        Text('Done!', style:  TextStyle(color: Colors.lightGreen, fontSize: 22.sp),)
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(50.0)),
              Column(
                children: [
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          // Perform search operation here...
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          // Clear the search query here...
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20.0)),

              Center(
                  child: SizedBox(
                width: 250,
                child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      BlocProvider.of<OperatingBloc>(context).add(AddOperationEvent(bin: widget.bin));
                      Navigator.pop(context , widget.bin.id ) ;
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 24.sp, color: Colors.white),
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
