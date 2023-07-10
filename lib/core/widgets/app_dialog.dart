import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppDialog extends StatelessWidget {
  Function()? ontap ;
  String? message  , title ;
  Icon? icon ;
  AppDialog({Key? key , this.title , this.message , this.icon , this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10.h) ,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon! ,
            Text(title!, style: parTextStyle,) ,
            Text(message! , style: parTextStyle,) ,
            OutlinedButton(onPressed: ontap, child: Text('حسنا')) ,
          ],
        ),
      ),
    );
  }
}

class AppDialogWithConfirm extends AppDialog {
  final Function() ontap ;
AppDialogWithConfirm({required this.ontap }):super() ;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10.h) ,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon! ,
            Text(title!, style: parTextStyle,) ,
            Text(message! , style: parTextStyle,) ,
            OutlinedButton(onPressed: ontap, child: Text('حسنا')) ,
          ],
        ),
      ),
    );
  }
}
