import 'package:form_validator/form_validator.dart';

RegExp email = RegExp(r"^[0-9A-Za-z]+");

RegExp phone = RegExp(r"^0\d{7}$");

RegExp password = RegExp(r"^[\d\w]{6,12}$");
class Validation extends FormValidatorLocale {
  @override
  String email(String v) {
    // TODO: implement email
    throw UnimplementedError();
  }

  @override
  String ip(String v) {
    // TODO: implement ip
    throw UnimplementedError();
  }

  @override
  String ipv6(String v) {
    // TODO: implement ipv6
    throw UnimplementedError();
  }

  @override
  String maxLength(String v, int n) {
    // TODO: implement maxLength
    throw UnimplementedError();
  }

  @override
  String minLength(String v, int n) {
    // TODO: implement minLength
    throw UnimplementedError();
  }

  @override
  String name() {
    // TODO: implement name
    throw UnimplementedError();
  }

  @override
  String phoneNumber(String v) {
    // TODO: implement phoneNumber
    throw UnimplementedError();
  }

  @override
  String required() => 'هذا الحقل مطلوب' ; 

  @override
  String url(String v) {
    // TODO: implement url
    throw UnimplementedError();
  }
  
}
class Validators {
  get userIdV => ValidationBuilder(locale: Validation())
      .regExp(RegExp(r'^(?![0-9])[\w\d]+$'),
      'يجب ان يحتوي على حروف وأرقام فقط ').required('هذا الحقل ضروري')
      .build();
  get nameV => ValidationBuilder(locale: Validation())
      .regExp(RegExp(r'^[a-zA-Z0-9]{8,15}$'),
          'يجب ان يجتوي الاسم على ارقام وحروف فقط و ان يتكون من 15 أحرف ').required('هذا الحقل ضروري')
      .build();

  get passwordV => ValidationBuilder(locale: Validation())
      .regExp(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$'),
          'يجب ان يتكون على الاقل من  7 حروف وارقام ورموز خاصة ').required('هذا الحقل ضروري')
      .build();

  get idV => ValidationBuilder(locale: Validation())
      .regExp(RegExp(r'^[a-zA-Z0-9]{20}$'),
      'يجب ان يجتوي الاسم على ارقام وحروف فقط و ان يتكون من 20 حرف').required('هذا الحقل ضروري')
      .build();

}
