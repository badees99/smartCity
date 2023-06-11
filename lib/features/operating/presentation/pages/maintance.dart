import 'package:flutter/material.dart';

class Maintance extends StatelessWidget {
  const Maintance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Maintance'),
      ),
      body:const SingleChildScrollView(),
    );
  }
}
