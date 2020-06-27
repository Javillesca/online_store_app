import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:onlinestorecapp/src/blocs/validators.dart';

class LoginBloc with Validators {
  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperación de streams con validators
  Stream<String> get emailStream     => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream  => _passwordController.stream.transform(validatePassword);
  Stream<bool> get formValidStream   =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Add valores de propiedades
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // GET valores de propiedades
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}