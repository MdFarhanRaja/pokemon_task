import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseClass<T extends StatefulWidget> extends State<T> {
  BaseClass() {}

  Future<Object?> gotoNext(Widget v) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (mContext) => v),
    );
  }

  Future<Object?> gotoNextWithNoBack(Widget widget) async {
    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  bool isIOS() {
    return Platform.isIOS;
  }

  bool isNullOrEmpty(String? data) {
    return data == null || data == '';
  }

  void onBackPress({Object? result}) {
    Navigator.pop(context, result);
  }

  SizedBox getHorizontalGap({double width = 20}) {
    return SizedBox(width: width);
  }

  SizedBox getVerticalGap({double height = 20}) {
    return SizedBox(height: height);
  }

  void changeSystemUiColor({
    Color statusBarColor = Colors.white,
    Color navBarColor = Colors.white,
    Brightness statusBarBrightness = Brightness.dark,
    Brightness navBarBrightness = Brightness.dark,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: navBarColor, // navigation bar color
        statusBarColor: statusBarColor, // status bar color
        statusBarIconBrightness: statusBarBrightness, // status bar icon color
        systemNavigationBarIconBrightness:
            navBarBrightness, // color of navigation controls
      ),
    );
  }

  bool isProgress = false;
  void showProgress({String? msg}) {
    isProgress = true;
    /* changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: AppTheme.white.withOpacity(0.9)); */
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white,
              ),
              child: const CircularProgressIndicator(
                color: Color(0xFFddb12e),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: true,
      barrierColor: Colors.white.withOpacity(0.9),
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: alert,
        );
      },
    );
  }

  void hideProgress() {
    if (isProgress) {
      isProgress = false;
      Navigator.pop(context);
    }
  }
}
