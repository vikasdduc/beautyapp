import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:glamcode/view/screens/login/login_screen.dart';
import 'package:glamcode/view/screens/profile/widget/register_profile.dart';
import 'blocs/auth/auth_bloc.dart';

class Home extends StatelessWidget {
  final AuthBloc authBloc;
  const Home({Key? key, required this.authBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        if (state is UnauthenticatedState) {
          return LoginPage(
            authBloc: authBloc,
          );
        } else if (state is AuthenticatedState) {
          if(state.user.name == null || state.user.name == "") {
            return RegisterProfileScreen(user: state.user);
          } else {
            return  const DashboardScreen(pageIndex: 0);
          }
        } else if (state is LoadingAuthenticationState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorAuthenticationState) {
          return const Scaffold(
            body: Center(
              child: Text("Something is wrong"),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("something is wrong"),
            ),
          );
        }
      },
    );
  }
}

/*
TextButton(
onPressed: () => {
authBloc.userRepository.signIn(),
authBloc.add(AppLoaded())
},
child: const Text('Login')),
TextButton(
onPressed: () => {
authBloc.userRepository.signOut(),
authBloc.add(AppLoaded())
},
child: const Text('logout')),*/
