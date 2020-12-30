import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'file:///C:/Users/amahdy/AndroidStudioProjects/news_app/lib/screens/main_screens/home.dart';

class Confirmation extends StatelessWidget {
  static const String id = 'confirmation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/checked.svg',
              width: 200.0,
              height: 200,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Account Created',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
            Text(
              'Successfully',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Home.id);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Theme.of(context).accentColor,
                  elevation: 20.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
