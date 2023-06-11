import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';

class BinInfo extends StatelessWidget {

  final Bin bin ;
  BinInfo({Key? key, required this.bin}) : super(key: key);
  bool _isOntop = false ;
  @override
  Widget build(BuildContext context) {
    _isOntop = true ;
    return AnimatedPositioned(
      duration: const Duration(),
      child: Container(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipOval(
              child: Image.asset('name'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(bin.name),
                Text(bin.status),
                Text(bin.longitude),
                Text(bin.latitude),
              ],
            )
          ],
        ),
      ),
    );
  }
}
