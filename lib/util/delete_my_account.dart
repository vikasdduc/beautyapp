import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/data/api/api_helper.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../home.dart';

class DeleteMyAccount extends StatefulWidget {
  const DeleteMyAccount({super.key});

  @override
  State<DeleteMyAccount> createState() => _DeleteMyAccountState();
}

class _DeleteMyAccountState extends State<DeleteMyAccount> {
  DioClient dio = DioClient.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Center(
                child: CupertinoButton(
                    color: Colors.red,
                    child: const Text(
                      "Confirm Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      dio.deleteUser();
                      context.read<CartBloc>().add(CartCleared());
                      final AuthBloc authBloc = context.read<AuthBloc>();
                      authBloc.userRepository.signOut();
                      authBloc.add(AppLoaded());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => Home(authBloc: authBloc)),
                          ModalRoute.withName('/index'));
                    })),
          )
        ],
      ),
    );
  }
}
