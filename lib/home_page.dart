import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
