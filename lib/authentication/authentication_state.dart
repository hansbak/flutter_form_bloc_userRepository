import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;

  const AuthenticationAuthenticated({@required this.token}) 
    : assert(token != null);

  @override
  List<Object> get props => [token];
}

class AuthenticationLoading extends AuthenticationState {}
