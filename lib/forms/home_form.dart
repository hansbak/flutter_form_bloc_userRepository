import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../authentication/authentication.dart';
import '../blocs/home_form_bloc.dart';

class HomeForm extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  HomeForm({@required this.authenticationBloc})
      : assert(authenticationBloc != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeFormBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: BlocBuilder<HomeFormBloc, FormBlocState>(
        condition: (previous, current) =>
            previous.runtimeType != current.runtimeType ||
            previous is FormBlocLoading && current is FormBlocLoading,
        builder: (context, state) {
          if (state is FormBlocLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            final homeFormBloc = context.bloc<HomeFormBloc>();
            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
              ),
              body: Container(
                child: Center(
                  child: RaisedButton(
                    child: Text('You are logged in, press here for logout: ${homeFormBloc.token.value}'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                    },
                )),
              ),
            );
          }
        }
      )
    );
  }
}
