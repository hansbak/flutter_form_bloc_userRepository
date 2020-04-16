import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../authentication/authentication.dart';
import 'package:flutter/foundation.dart';
class LoginFormBloc extends FormBloc<String, String> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  final email = TextFieldBloc(
    initialValue: 'test@example.com',
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    initialValue: 'paaassswwword',
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final showSuccessResponse = BooleanFieldBloc();

  LoginFormBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
    })  : assert(userRepository != null),
        assert(authenticationBloc != null)
    {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
        showSuccessResponse,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print(email.value);
    print(password.value);
    print(showSuccessResponse.value);

    try{
      final token = await userRepository.authenticate(
        username: email.value,
        password: password.value,
      );
      if (!showSuccessResponse.value) {
        authenticationBloc.add(LoggedIn(token: token));
        emitSuccess();
      } else {
        emitFailure(failureResponse: 'Awsome Error!');
      }
    } catch (e) {
       // TODO: Map exception to error message 
      emitFailure(failureResponse: e.toString());
    }
  }
}