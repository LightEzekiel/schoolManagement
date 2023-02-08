import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phrankstar/models/basic_school_class.dart';
import 'package:phrankstar/models/basic_school_class_staff.dart';
import 'package:phrankstar/models/http_exception.dart';
import 'package:phrankstar/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:phrankstar/workArea/update_basic_staff.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'basic.dart';

class BasicSchoolStaffAdmin extends StatefulWidget {
  static const routeName = '/basic-school-staff';

  const BasicSchoolStaffAdmin({super.key});

  @override
  State<BasicSchoolStaffAdmin> createState() => _BasicSchoolStaffAdminState();
}

class _BasicSchoolStaffAdminState extends State<BasicSchoolStaffAdmin> {
  Future<void> _refreshProduct(BuildContext context) async {
    try {
      await Provider.of<PCAS>(context, listen: false).fetchAndSetBasicStaff();
    } on HttpException catch (error) {
      var errorMessage = 'No staff yet!';
      _showErrorMessage(errorMessage, context);
    } catch (error) {
      if (error.toString().contains('Null')) {
        var errorM = 'No staff added yet!';
        _showErrorMessage(errorM, context);
      } else {
        var errorM = 'Check your network connection!';
        _showErrorMessage(errorM, context);
      }
    }
  }

  void _showErrorMessage(String message, BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Network Message',
                style: TextStyle(color: oxblood),
              ),
              content: Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                    onPressed: () =>
                        Navigator.of(ctx, rootNavigator: true).pop(),
                    child: Text(
                      'OK',
                      style: TextStyle(color: oxblood),
                    )),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => this.build(context))),
                    child: Text(
                      'RETRY',
                      style: TextStyle(color: oxblood),
                    )),
              ],
            ));
  }

  String? Name;
  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // staff = Provider.of<PCAS>(context).staff;
    return SafeArea(
        child: Scaffold(
      key: null,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: oxblood),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Basic School Staff',
          style: TextStyle(color: oxblood),
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsets.all(10),
          //   child: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           typing = !typing;
          //         });
          //       },
          //       icon: Icon(
          //         typing ? Icons.done : Icons.search,
          //         color: oxblood,
          //       )),
          // ),
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              splashColor: oxblood,
              child: IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/Add-BasicStaff'),
                  icon: Icon(
                    Icons.person_add,
                    color: oxblood,
                  )),
            ),
          ),

          if (Responsive.isDesktop(context) || Responsive.isTablet(context))
            Padding(
              padding: EdgeInsets.all(12),
              child: InkWell(
                child: IconButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => this.build(context))),
                    icon: Icon(
                      Icons.refresh,
                      color: oxblood,
                    )),
              ),
            ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: oxblood,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Fetching staff...\nPlease wait',
                      style: TextStyle(color: oxblood, fontSize: 14),
                    )
                  ],
                ),
              )
            : RefreshIndicator(
                color: oxblood,
                onRefresh: () => _refreshProduct(context),
                child: SizedBox(
                  height: size.height,
                  child: Consumer<PCAS>(
                    builder: (ctx, staffDetails, _) {
                      return Column(
                        children: [
                          // (Responsive.isDesktop(context))
                          //     ? Card(
                          //         elevation: 0,
                          //         margin: EdgeInsets.only(
                          //             left: 250, right: 250, top: 5),
                          //         child: Container(
                          //           alignment: Alignment.centerRight,
                          //           color: Colors.white,
                          //           child: TextField(
                          //             onChanged: (value) {
                          //               // _runFilter(value);
                          //               // staffName = value;
                          //               // setState(() {
                          //               //   // searchString = value;
                          //               // });
                          //             },
                          //             decoration: InputDecoration(
                          //                 border: InputBorder.none,
                          //                 enabledBorder: UnderlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                     width: 1,
                          //                     color: oxblood,
                          //                   ),
                          //                 ),
                          //                 hintText: 'Search Staff',
                          //                 hintStyle:
                          //                     TextStyle(color: Colors.black)),
                          //           ),
                          //         ),
                          //       )
                          //     : Card(
                          //         elevation: 0,
                          //         margin: EdgeInsets.only(
                          //             left: 10, right: 10, top: 5),
                          //         child: TextField(
                          //             decoration: InputDecoration(
                          //                 border: InputBorder.none,
                          //                 enabledBorder: UnderlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                     width: 1,
                          //                     color: oxblood,
                          //                   ),
                          //                 ),
                          //                 hintText: 'Search Staff',
                          //                 hintStyle:
                          //                     TextStyle(color: Colors.black)),
                          //             onChanged: (value) {
                          //               // searchString = value.toLowerCase();
                          //             }),
                          //       ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: staffDetails.staff.length,
                                itemBuilder: (context, i) {
                                  staffs = staffDetails.staff;

                                  return Responsive.isDesktop(context)
                                      ?

                                      //
                                      // return
                                      //  staffDetails.staff[i].staff_name1!.contains(searchString.toLowerCase())
                                      //     ?

                                      //  staffDetails.findBySearch(searchString).toString()?

                                      Card(
                                          elevation: 5,
                                          margin: EdgeInsets.only(
                                              right: 250,
                                              left: 250,
                                              top: 2,
                                              bottom: 10),
                                          child: InkWell(
                                            splashColor: oxblood,
                                            child: ListTile(
                                              onTap: () {
                                                key:
                                                UniqueKey();
                                                Navigator.of(context).pushNamed(
                                                    BasicSchoolProfileAdmin
                                                        .routeName,
                                                    arguments: {
                                                      'heroTag': UniqueKey(),
                                                      'staffid': staffDetails
                                                          .staff[i].id
                                                    }).then((value) {
                                                  setState(() {});
                                                });
                                              },
                                              title: Text(
                                                staffDetails
                                                    .staff[i].staff_name1!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                              ),
                                              subtitle: Text(
                                                  staffDetails.staff[i].payable!
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  child: IconButton(
                                                    color: Colors.white,
                                                    icon: Icon(Icons.person),
                                                    onPressed: () {},
                                                  )),
                                              trailing: InkWell(
                                                splashColor: oxblood,
                                                child: IconButton(
                                                  splashColor: oxblood,
                                                  icon: Icon(
                                                      Icons.edit_note_outlined),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            UpdateBasicStaff
                                                                .routeName,
                                                            arguments:
                                                                staffDetails
                                                                    .staff[i].id
                                                                    .toString());
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          elevation: 5,
                                          margin: EdgeInsets.only(
                                              right: 10,
                                              left: 10,
                                              top: 2,
                                              bottom: 5),
                                          child: InkWell(
                                            splashColor: oxblood,
                                            child: ListTile(
                                              onTap: () {
                                                key:
                                                UniqueKey();
                                                Navigator.of(context).pushNamed(
                                                    BasicSchoolProfileAdmin
                                                        .routeName,
                                                    arguments: {
                                                      'heroTag': UniqueKey(),
                                                      'staffid': staffDetails
                                                          .staff[i].id
                                                    }).then((value) {
                                                  setState(() {});
                                                });
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (BuildContext context) =>
                                                //             BasicSchoolProfileAdmin(
                                                //               id: staffDetails.staff[i].id,
                                                //               key:UniqueKey()
                                                //               ,
                                                //             )));
                                              },
                                              title: Text(
                                                staffDetails
                                                    .staff[i].staff_name1!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                              ),
                                              subtitle: Text(
                                                  staffDetails.staff[i].payable!
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  child: IconButton(
                                                    color: Colors.white,
                                                    icon: Icon(Icons.person),
                                                    onPressed: () {},
                                                  )),
                                              trailing: InkWell(
                                                splashColor: oxblood,
                                                child: IconButton(
                                                  splashColor: oxblood,
                                                  icon: Icon(
                                                      Icons.edit_note_outlined),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            UpdateBasicStaff
                                                                .routeName,
                                                            arguments:
                                                                staffDetails
                                                                    .staff[i].id
                                                                    .toString());
                                                    // Navigator.of(context)
                                                    //     .pushNamed('/update-basic-staff');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          // print('FloatingActionButton Pressed');
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text(
                      'UPDATE ALL STAFF?',
                      style: TextStyle(color: oxblood),
                    ),
                    content: Text(
                      'All staff details will be updated!.',
                      style: TextStyle(color: Colors.black),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                          child: Text(
                            'NO',
                            style: TextStyle(color: oxblood),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            updateStaffAllowance(context);
                            // fetch(context);
                          },
                          child: Text(
                            'YES',
                            style: TextStyle(color: oxblood),
                          ))
                    ],
                  ));
        },
        child: Icon(
          Icons.update,
          size: 29,
          color: oxblood,
        ),
        splashColor: oxblood,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ));
  }

  List<PCA>? staffs;
  var isLoading = false;

  Future<void> updateStaffAllowance(BuildContext ctx) async {
    // staffDetails.staff.forEach((element) {});
    for (var staff in staffs!) {
      String? id;
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('EEE,dd MMM, yy');
      var currentDate = formatter.format(now);
      String trackingDate2 = staff.trackingDate.toString().isEmpty
          ? currentDate
          : staff.trackingDate.toString();
      DateTime d1 = new DateFormat("EEE,dd MMM, yy").parse(trackingDate2);
      DateTime d2 = new DateFormat("EEE,dd MMM, yy").parse(currentDate);

      final diff = d2.difference(d1);
      var remainingLoanUpdate;
      // print(diff.inDays);
      id = staff.id;

      if (staff.remainingLoan.toString().isNotEmpty) {
        remainingLoanUpdate = double.parse(staff.remainingLoan!);
      }

      if (staff.trackingDate.toString().isNotEmpty && diff.inDays >= 20) {
        setState(() {
          isLoading = true;
        });

        if (diff.inDays >= 20 &&
            staff.staffLoan1.toString().isNotEmpty &&
            remainingLoanUpdate > 0) {
          var staffLoanPaid = double.parse(staff.loanPaid!);

          staffLoanPaid += double.parse(staff.staffLoanPayPerMonth1!);
          remainingLoanUpdate -= double.parse(staff.staffLoanPayPerMonth1!);
          try {
            final url1 =
                'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
            final response1 = await http.patch(Uri.parse(url1),
                body: json.encode({
                  'loanPaid': staffLoanPaid.toString(),
                  'remainingLoan': remainingLoanUpdate.toString(),
                  'trackingDate': currentDate,
                }));
          } catch (error) {
            var errorM =
                'Could not update staff loan details.\n Try again later.';
            _showErrorMessage(errorM, context);
          }

          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 20),
            content: Text(
              '${staff.staff_name1!} Loan details updated',
              style: const TextStyle(color: oxblood),
            ),
          ));
        } else {
          if (diff.inDays >= 20 && staff.staffLoan1.toString().isNotEmpty) {
            String payable = staff.payable.toString();
            int lpayperm = int.parse(staff.staffLoanPayPerMonth1!);
            double payableUpdate = lpayperm.toDouble() + double.parse(payable);

            final url2 =
                'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
            final response2 = await http.patch(Uri.parse(url2),
                body: json.encode({
                  'payable': payableUpdate,
                  'staffLoan1': '',
                  'staffLoanPayPerMonth1': '',
                  'loanPaid': '',
                  'remainingLoan': '',
                }));
            if (response2.statusCode >= 400) {
              var errorM =
                  'Could not update staff loan details.\n Try again later.';
              _showErrorMessage(errorM, context);
            }

            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              duration: Duration(seconds: 20),
              content: Text(
                '${staff.staff_name1!} Loan cleared',
                style: const TextStyle(color: oxblood),
              ),
            ));
          }
        }

        if (diff.inDays >= 20 && staff.staffSavings1.toString().isNotEmpty) {
          var savings = double.parse(staff.staffSavings1!);
          var savingsPerMth = double.parse(staff.staffSavingsPerMonth1!);
          savings += savingsPerMth;
          final url3 =
              'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
          final response2 = await http.patch(Uri.parse(url3),
              body: json.encode({
                'staffSavings1': savings.toString(),
                'trackingDate': currentDate,
              }));
          if (response2.statusCode >= 400) {
            var errorM =
                'Could not update staff Savings details.\n Try again later.';
            _showErrorMessage(errorM, context);
          }
        }
        if (diff.inDays >= 20 && staff.staffDeduction1.toString().isNotEmpty) {
          var payableUpdate = double.parse(staff.payable.toString());
          payableUpdate += double.parse(staff.staffDeduction1!);

          final url4 =
              'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
          final response4 = await http.patch(Uri.parse(url4),
              body: json.encode({
                'payable': payableUpdate,
                'staffDeduction1': '',
              }));
          if (response4.statusCode >= 400) {
            var errorM =
                'Could not update staff Debt details.\n Try again later.';
            _showErrorMessage(errorM, context);
          }
        }

        if (diff.inDays >= 20 && staff.staffBonus1.toString().isNotEmpty) {
          int staffbonus = int.parse(staff.staffBonus1!);

          double payable = double.parse(staff.payable.toString());
          var payableUpdate = payable.toDouble() - staffbonus.toDouble();

          final url5 =
              'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
          final response5 = await http.patch(Uri.parse(url5),
              body: json.encode({'payable': payableUpdate, 'staffBonus1': ''}));
          if (response5.statusCode >= 400) {
            var errorM =
                'Could not update staff Payment details.\n Try again later.';
            _showErrorMessage(errorM, context);
          }
        }

        if (diff.inDays >= 20 &&
            staff.staffResignationAllowance1.toString().isNotEmpty) {
          var totalPay = (double.parse(staff.staffSalary1!) / 100) * 10;
          var staffAllowanceIncrement =
              totalPay + double.parse(staff.staffResignationAllowance1!);
          final url7 =
              'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
          final response5 = await http.patch(Uri.parse(url7),
              body: json.encode({
                'staffResignationAllowance1':
                    staffAllowanceIncrement.toString(),
              }));
          if (response5.statusCode >= 400) {
            var errorM =
                'Could not update staff staffResignationAllowance1 details.\n Try again later.';
            _showErrorMessage(errorM, context);
          }
        }

        setState(() {
          isLoading = false;
        });
      } else {
        return showDialog(
            barrierDismissible: true,
            context: context,
            builder: (ctx) => AlertDialog(
                  content: Text(
                    'STAFF DETAILS ARE UP TO DATE',
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop(),
                        child: Text(
                          'OK',
                          style: TextStyle(color: oxblood),
                        )),
                  ],
                ));
      }

      if (diff.inDays >= 365 &&
          staff.staffResignationAllowance1.toString().isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        double staffYearAllowance =
            double.parse(staff.staffResignationAllowance1!);
        String staffEndOfTheYearTxtV = "Balance at " + currentDate + ": ";

        final url6 =
            'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
        final response5 = await http.patch(Uri.parse(url6),
            body: json.encode({
              'staffYearAllowanceBalance': staffYearAllowance.toString(),
              'staffEndOfYearAllowanceTxtV': staffEndOfTheYearTxtV.toString(),
            }));
        if (response5.statusCode >= 400) {
          var errorM =
              'Could not update staff StaffYearAllowanceBalance details.\n Try again later.';
          _showErrorMessage(errorM, context);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
