import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication/authentication.dart';
import 'splash_page.dart';
import 'forms/home_form.dart';
import 'forms/login_form.dart';
import 'widgets/widgets.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  final authenticationBloc = AuthenticationBloc(userRepository: userRepository);

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository, 
                 authenticationBloc: authenticationBloc,),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  App({Key key, @required this.userRepository,
                @required this.authenticationBloc})
    : assert(userRepository != null,
             authenticationBloc != null),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomeForm(authenticationBloc: authenticationBloc);
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginForm(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}
