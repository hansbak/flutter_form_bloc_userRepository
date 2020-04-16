import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../authentication/authentication.dart';
import 'dart:async';


class HomeFormBloc extends FormBloc<String, String> {
  final AuthenticationBloc authenticationBloc;
  final company = TextFieldBloc();
  var companyName;
  StreamSubscription authSubscription;

  HomeFormBloc({@required this.authenticationBloc})
    : assert(authenticationBloc != null),
      super(isLoading: true) {
      addFieldBlocs(fieldBlocs: [company]);
      authSubscription = authenticationBloc.listen((state) {
      print("==2==is state: $state");
      if (state is AuthenticationAuthenticated) {
        companyName = (authenticationBloc.state as AuthenticationAuthenticated)
          .token;
        print("==company1==$companyName"); //ok
      }
    });
    print("==company9==$companyName"); //ok
    company.updateInitialValue("99");
  }

  @override
  void onSubmitting() {
    // TODO: implement onSubmitting
  }

  @override
  void onLoading() { // for reload
    print("==start loading ====");
    print("==company2==$companyName");
    if (companyName != null) {
      company.updateInitialValue(companyName.toString());
      print("==end company.value: ${company.value}");
    } // else company.updateInitialValue("!!!");
    print("==end loading ====");
    emitLoaded();
  }
  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}



