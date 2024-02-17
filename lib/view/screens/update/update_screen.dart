import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:upgrader/upgrader.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../home.dart';

class UpdateScreen extends StatelessWidget {
  final AuthBloc authBloc;
  final cfg = AppcastConfiguration(
      // url:
      //     'https://raw.githubusercontent.com/jeejaykim/apispa/jeejaykim-test/test.xml',
      url:
          'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml',
      supportedOS: ['android', 'ios']);

  UpdateScreen({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Navigation'),
                content: const Text(
                    'Are you sure you want to navigate away from this screen?'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('CANCEL'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('OK'),
                    ),
                  ),
                ],
              );
            },
          );
          return false;
        },
        child: Scaffold(
            body: UpgradeAlert(
          upgrader: Upgrader(
            client: Client(),
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
            // appcastConfig: cfg,
            // debugLogging: true,
            showLater: false,
            showIgnore: false,
            minAppVersion: '2.0.1',
            shouldPopScope: () => false,
            onIgnore: () => false,
            onLater: () => false,
            onUpdate: () => true,
            debugDisplayAlways: true,
            canDismissDialog: false,
          ),
          // child: const Center(child: Text("checking for updates...")),
          child: Home(authBloc: authBloc),
        )));
  }
}
