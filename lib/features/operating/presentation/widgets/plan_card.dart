import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanCard extends StatelessWidget {
  final String id;
  final String date , site  ;

  const PlanCard({Key? key, required this.id , required this.date , required this.site})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
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
                  Text(id, style: TextStyle(fontSize: 24.sp))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Column(
                children: [

                  Text(
                    '$id الخطة رقم',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Text(
                    '$site :الموقع',
                    style: TextStyle(fontSize: 18.sp),
                  ),Text(
                    '$date :التاريخ',
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
