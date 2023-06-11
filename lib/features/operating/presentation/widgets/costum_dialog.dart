import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomDialog extends StatelessWidget {
  static bool toggle = false  ;
  final Widget icon ;
  String message = '';
  CustomDialog({Key? key , required  this.icon , required this.message  } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            Text(
              message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                toggle = !toggle ;
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
