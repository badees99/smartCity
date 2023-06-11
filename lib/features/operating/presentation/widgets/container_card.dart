import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Container_Card extends StatelessWidget {
  final String id;
  final String status , latitude , longtude ;

  const Container_Card({Key? key, required this.id, required this.status , required this.latitude , required this.longtude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0))
      ),
      elevation: 10.0,
      child: InkWell(
        onTap: (){

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                children: [
                  Icon(
                    Icons.delete,
                    size: 48.h,
                    color: double.parse(status) <= 50
                        ? Colors.green
                        : double.parse(status) <= 70
                            ? Colors.orange
                            : Colors.red,
                  ),
                  Text(status, style: TextStyle(fontSize: 24.sp))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Column(
                children: [

                  Text(
                    '$id الحاوية رقم',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Text(
                    '$latitude , $longtude :الموقع',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
