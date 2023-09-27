import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialogUtil {
  static void showAppLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 48,
            height: 48,
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }

  static void closeAppLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
