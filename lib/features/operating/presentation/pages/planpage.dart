import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/state.dart';
import 'package:smartcity/features/operating/presentation/widgets/plan_card.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plan Page'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Navigator.pushNamed(context, 'mapscreen/');
        }, label:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            Text("ابدا العمل " , textDirection: TextDirection.rtl, style: TextStyle(
              fontSize: 22.sp
            ),) ,
            const  Icon(Icons.navigate_next_rounded)
          ],
        )),
        body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder <OperatingBloc, OperatingState>(
                    builder: (context, state) {
                      if (state is LoadingOperatingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SuccessPlanLoad) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(18.0))
                          ),
                          elevation: 10.0,
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text('الخطة الحالية  ', style: TextStyle(
                                    fontSize: 32.sp
                                ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.map_outlined,
                                            size: 48.h,
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${state.planModel.id}الخطة رقم ',
                                            style: TextStyle(fontSize: 18.sp),
                                          ),
                                          Text(
                                            ' ${state.planModel
                                                .siteId } اسم الموقع ',
                                            style: TextStyle(fontSize: 18.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                ),

                const Divider(),
                // BlocBuilder<OperatingBloc, OperatingState>(
                //   builder: (context, state) {
                //     if (state is LoadingOperatingState) {
                //       return CircularProgressIndicator();
                //     } else if (state is SuccessPlanLoad) {
                //       return ListView.builder(
                //         itemCount: 3,
                //         itemBuilder: (context, index) =>
                //             PlanCard(id: state.planModel.id,
                //                 date: state.planModel.timeStamp.toDate()
                //                     .toString(),
                //                 site: state.planModel.siteId),
                //
                //         scrollDirection: Axis.vertical,
                //         shrinkWrap: true,
                //       );
                //     } else {
                //       return Container();
                //     }
                //   },
                // ),

              ],
            )));
  }
}
