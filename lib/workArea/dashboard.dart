import 'package:flutter/material.dart';
import 'package:phrankstar/constants.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryDashboard extends StatelessWidget {
  static const routeName = '/primary-dashboard';
  const PrimaryDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //     elevation: 0,
          //     backgroundColor: Colors.white,
          //     leading: IconButton(
          //         onPressed: () => Navigator.of(context).pop(),
          //         icon: Icon(
          //           Icons.arrow_back,
          //           color: oxblood,
          //         ))
          //         ),
          body: Row(
            children: [
              Expanded(
                  child: Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.arrow_back,
                                color: oxblood,
                              )),
                          // DrawerHeader(
                          //   child: Image(
                          //     fit: BoxFit.cover,
                          //     image: AssetImage('assets/images/phrankstars.png'),
                          //     height: MediaQuery.of(context).size.height / 40,
                          //     width: MediaQuery.of(context).size.width / 40,
                          //   ),
                          // ),
                        ],
                      ),
                      DrawerListTIle(
                          title: 'DashBoard',
                          svgSrc: 'assets/icons/menu_dashbord.svg',
                          press: () {}),
                      DrawerListTIle(
                          title: 'Edit staff',
                          svgSrc: 'assets/icons/menu_notification.svg',
                          press: () {}),
                      DrawerListTIle(
                          title: 'Print Document',
                          svgSrc: 'assets/icons/menu_tran.svg',
                          press: () {}),
                      DrawerListTIle(
                          title: 'Disable Staff',
                          svgSrc: 'assets/icons/menu_store.svg',
                          press: () {}),
                    ],
                  ),
                ),
              )),
              Expanded(
                  flex: 5,
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16),
                      itemBuilder: (ctx, i) => Card(
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: oxblood.withOpacity(0.15),
                                      width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Row(
                                    children: [],
                                  ),
                                  Text(
                                    'Sun,02 Oct,22',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text('Basic Salary',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.black)),
                                  Text('#50,000',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(color: oxblood)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Increment',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )))
            ],
          )),
    );
  }
}

class DrawerListTIle extends StatelessWidget {
  const DrawerListTIle({
    Key? key,
    required this.press,
    required this.title,
    required this.svgSrc,
  }) : super(key: key);

  final VoidCallback press;
  final String title, svgSrc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      horizontalTitleGap: 0,
      title: Text(title),
      leading: SvgPicture.asset(
        svgSrc,
        color: Theme.of(context).primaryColor,
        height: 16,
      ),
    );
  }
}
