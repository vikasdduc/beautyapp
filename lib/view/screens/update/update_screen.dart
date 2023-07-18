import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class UpdateScreen extends StatelessWidget {
  final cfg = AppcastConfiguration(
      url:
          'https://raw.githubusercontent.com/jeejaykim/apispa/jeejaykim-test/test.xml',
      supportedOS: ['android', 'ios']);

  UpdateScreen({super.key});
  //final bool isUpdate;
  //const UpdateScreen({Key? key, required this.isUpdate}) : super(key: key);
  // Future<PackageInfo> _getPackageInfo() {
  //   return PackageInfo.fromPlatform();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Navigation'),
              content: const Text('Are you sure you want to navigate away from this screen?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return false;
      }, child: 
    Scaffold(
        body: UpgradeAlert(
      upgrader: Upgrader(
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
        appcastConfig: cfg,
        debugLogging: true,
        showLater: false,
        showIgnore: false,
        minAppVersion: '1.2.6',
        shouldPopScope: () => true,
      ),
      child: const Center(child:Text("checking")),
    )));
  }

  
}
