import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';
import 'package:smartcity/constants.dart';
import 'package:smartcity/core/widgets/app_regex.dart';
import 'package:smartcity/features/operating/data/models/report.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/event.dart';

import 'package:uuid/uuid.dart';

class ReportScreen extends StatefulWidget {
  final Bin bin;

  const ReportScreen({Key? key, required this.bin}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController descriptioController = TextEditingController();

  List<Widget> Photos = [];

  List<File> files = [];

  @override
  void initState() {
    files.clear();
    Photos.clear();
    FirebaseFirestore.instance
        .collection('Bins')
        .doc('9Iooq6WyK8sqecBpyfQs')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data != null &&
          data['status'] != null &&
          double.parse(data['status'].toString()) < 25) {
        // Update the state of your application here based on the updated data
        setState(() {
          // Example state update:
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  validator: Validators().required,
                  controller: descriptioController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "وصف مختصر للخلل"
                  ),
                  maxLines: 4,
                  minLines: 4,
                ),
                SizedBox(height: defaultPadding,),
                const Text(
                    'اضف بعض الصور للخلل', textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right),
                SizedBox(height: defaultPadding,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...Photos,
                      InkWell(
                        onTap: () {
                          capturePhoto();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white,
                          ),
                          height: 120.h,
                          width: 120.w,
                          child: Icon(Icons.add, size: 48.w,),
                        ),
                      ),
                      SizedBox(width: defaultPadding,),
                    ],
                  ),
                ) ,
                SizedBox(height: defaultPadding,) ,
                Center(
                    child: SizedBox(
                      width: 100.w,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            BlocProvider.of<OperatingBloc>(context).add(AddReportEvent(reportModel: ReportModel(
                              id: const Uuid().v1().replaceAll('-', ''),
                              addedBy: FirebaseAuth.instance.currentUser!.email! ,
                              binid: widget.bin.id ,
                              date: Timestamp.fromDate(DateTime.now()) ,
                              description: descriptioController.text ,
                              images: files ,
                            ))) ;
                            Navigator.pop(context);
                          },
                          child: Text(
                            'ابلاغ',
                            style:
                            TextStyle(fontSize: 20.sp, color: Colors.white),
                          )),
                    ),),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> capturePhoto() async {
    // Use the image_picker package to capture a photo
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      // No photo selected
      return;
    } else {
      files.add(File(pickedFile.path));
      filesToPhotosWidgets(files) ;
    }
    // Upload the photo to Firebase Storage
  }


  Future<void> filesToPhotosWidgets(List<File> files) async {
    setState(() {
      Photos.clear() ;
      for (var element in files) {
        Photos.add(
            InkWell(
              onLongPress: () {
                showDialog(context: context, builder: (context) =>
                    Dialog(
                      child: SizedBox(
                        height: 120.h,
                        width: 300.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: defaultPadding,) ,
                            Text('هل انت متاكد من حذف هذه الصورة ',
                              style: TextStyle(fontSize: 18.sp),),
                            SizedBox(height: defaultPadding,) ,
                            ElevatedButton.icon(onPressed: () {
                              setState(() {
                                files.remove(element) ;
                              });
                              filesToPhotosWidgets(files) ;
                              Navigator.pop(context) ;
                            },
                                icon: Icon(Icons.delete),
                                label: Text('حسنا')),
                          ],
                        ),
                      ),
                    ),);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                ),
                height: 120.h,
                width: 120.w,
                child: Image.file(element, fit: BoxFit.fill),
              ),
            )
        );

        Photos.add(SizedBox(width: defaultPadding,));
      }
    });

  }

}
