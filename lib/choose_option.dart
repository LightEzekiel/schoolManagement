import 'package:flutter/material.dart';
import 'package:phrankstar/authentications/basic_login.dart';
import 'package:phrankstar/authentications/high_school_login.dart';
import 'package:phrankstar/constants.dart';

class ChooseOption extends StatelessWidget {
  const ChooseOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(BasicLogin.routeName),
              splashColor: oxblood,
              child: Card(
                elevation: 10,
                child: Container(
                    height: deviceSize.height * 0.2,
                    width: deviceSize.width * 0.3,
                    child: Image.asset(
                      'assets/images/phrankstars.png',
                      height: 20,
                      width: 20,
                    )),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(HighSchoolLogin.routeName),
              splashColor: oxblood,
              child: Card(
                elevation: 10,
                child: Container(
                    height: deviceSize.height * 0.2,
                    width: deviceSize.width * 0.3,
                    child: Image.asset('assets/images/secondary_logo.png')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
