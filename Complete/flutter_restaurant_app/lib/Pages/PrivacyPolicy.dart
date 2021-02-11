import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    //functions
    _launchPrivacyURL() async {
      const url = 'https://www.berryxchange.org/privacy-policy/';
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        ).whenComplete(() {
          Navigator.pop(context);
        });
      } else {
        throw 'Could not launch $url';
      }
    }
    //------------------

    _launchPrivacyURL();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Privacy Policy"
        ),
      ),
      body: Container()
    );
  }
}
