import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

void launchWhatsApp(
    {@required String phone,
    }) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?";
    } else {
      return "whatsapp://send?phone=$phone&";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}