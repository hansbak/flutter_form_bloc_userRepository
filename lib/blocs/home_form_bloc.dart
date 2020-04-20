import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../authentication/authentication.dart';
import 'dart:async';


class HomeFormBloc extends FormBloc<String, String> {
  final AuthenticationBloc authenticationBloc;
  final token = TextFieldBloc();
  var tokenName;
  StreamSubscription authSubscription;

  HomeFormBloc({@required this.authenticationBloc})
    : assert(authenticationBloc != null),
      super(isLoading: true) {
      addFieldBlocs(fieldBlocs: [token]);
  }

  @override
  void onSubmitting() {
    // TODO: implement onSubmitting
  }

  @override
  void onLoading() async { // for reload
    try {
      print("==start loading ====");
      
      authSubscription = await authenticationBloc.listen((state) {
          print("==2==is state: $state");
          if (state is AuthenticationAuthenticated) {
            tokenName = 
              (authenticationBloc.state as AuthenticationAuthenticated).token;
            print("==token1==$tokenName"); //ok
          }
      });

      print("==token2==$tokenName");
      token.updateInitialValue(tokenName);
      print("==end token.value: ${token.value.toString()}");
      emitLoaded();
      print("==end loading ====");
    } catch(e) {
      emitLoadFailed(failureResponse: "catch, error: $e");
    }
  }
  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}

