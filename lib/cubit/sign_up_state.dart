part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSetup extends SignUpState {
  final TextEditingController? email;
  final TextEditingController? username;
  final TextEditingController? password;

  const SignUpSetup(this.username,this.email, this.password);

  @override
  List<Object> get props => [username!,email!, password!];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoaded extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpEmailValidating extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpEmailValidated extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpPasswordValidating extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpPasswordValidated extends SignUpState {
  @override
  List<Object> get props => [];
}



class SignUpUsernameValidating extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpUsernameValidated extends SignUpState {
  @override
  List<Object> get props => [];
}
