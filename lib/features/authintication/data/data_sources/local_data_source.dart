

import 'dart:js_interop';

import 'package:admin/Features/authintication/data/models/authUserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthLocalDataSource {
  Future<bool> authLogin(AuthUser user) ;
  Future<bool> authLogout() ;
}

class AuthLocalDataSourceImp extends AuthLocalDataSource{
  final firebaseAuth = FirebaseAuth.instance ;
  @override
  Future<bool> authLogin(AuthUser user) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(email: user.userId+'@admin.com', password: user.userPass) ;
    if(result.user!.uid == ''){
      throw FirebaseAuthException(code: '112') ;
    }else {
      return true ;
    }

  }

  @override
  Future<bool> authLogout() async {
     await firebaseAuth.signOut() ;

     if(firebaseAuth.currentUser.isNull){
       return true ;
     }else {
       throw FirebaseAuthException(code: '113') ;

     }
  }

}