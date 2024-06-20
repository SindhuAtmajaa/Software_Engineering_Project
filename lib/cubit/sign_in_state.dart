import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable{
  const SignInState();
}

class SignInInitial extends SignInState{
  @override
  List<Object?> get props => [];  
}


class SignInLoading extends SignInState{
  @override
  List<Object?> get props => [];  
}


class SignInLoaded extends SignInState{
  @override
  List<Object?> get props => [];  
}


class SignInSuccess extends SignInState{
  final String? username;

  const SignInSuccess({this.username});
  
  @override
  List<Object?> get props => [username];  
}


class SignInFailed extends SignInState{
  final String? message;

  const SignInFailed({this.message});
  
  @override
  List<Object?> get props => [message];  
}