import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/event.dart';
import 'package:smartcity/features/operating/presentation/manager/state.dart';
import 'package:smartcity/features/operating/presentation/widgets/container_card.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  void initState() {
    BlocProvider.of<OperatingBloc>(context).add(GetAllBinsEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,

        onPressed: (){

        },
        label: Text(
          'ابدأ مهمتك' ,
          style: TextStyle(
            fontSize: 28.sp
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('collction'),
        centerTitle: true,
      ),
      body: BlocBuilder<OperatingBloc, OperatingState>(
        builder: (context, state) {
          if(state is ErrorLoadingState){
              return const SnackBar(
                content:  Text(
                  ' Nothing  to Show',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              );
          }else if(state is BinsLoadedState) {
            return SizedBox(
              height: 1.sh,
              child: ListView.builder(
                itemCount: state.bins.length,
                  itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container_Card(
                    latitude: state.bins[index].latitude.toString(),
                    longtude: state.bins[index].longitude.toString() ,
                    status: state.bins[index].status.toString(),
                    id: state.bins[index].name.toString(),
                  ),
                );
              },

                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }

          },
      ),
    );
  }
}
