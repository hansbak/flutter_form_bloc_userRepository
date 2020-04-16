import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication.dart';
import '../blocs/home_form_bloc.dart';

class HomeForm extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  HomeForm({Key key, @required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeFormBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: Builder(
        builder: (context) {
          final homeFormBloc = context.bloc<HomeFormBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Container(
              child: Center(
                child: RaisedButton(
                child: Text('You are logged in, press here for logout'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )),
            ),
          );
        }
      )
    );
  }
}
