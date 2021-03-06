import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../blocs/login_form_bloc.dart';
import '../authentication/authentication.dart';
import '../widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  final UserRepository userRepository;

  LoginForm({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
      ),
      child: Builder(
        builder: (context) {
          final loginFormBloc = context.bloc<LoginFormBloc>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text('Login')),
            body: FormBlocListener<LoginFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    TextFieldBlocBuilder(
                      textFieldBloc: loginFormBloc.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: loginFormBloc.password,
                      suffixButton: SuffixButton.obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: CheckboxFieldBlocBuilder(
                        booleanFieldBloc: loginFormBloc.showSuccessResponse,
                        body: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Show failure response'),
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: loginFormBloc.submit,
                      child: Text('LOGIN'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
