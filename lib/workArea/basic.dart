import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phrankstar/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:phrankstar/models/http_exception.dart';
import 'package:phrankstar/responsive.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/basic_school_class.dart';
import '../models/basic_school_class_staff.dart';

class BasicSchoolProfileAdmin extends StatefulWidget {
  static const routeName = '/basic-school-admin';

  @override
  State<BasicSchoolProfileAdmin> createState() =>
      _BasicSchoolProfileAdminState();
}

class _BasicSchoolProfileAdminState extends State<BasicSchoolProfileAdmin> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  var _editedStaff = PCA(
      staff_name1: '',
      staff_position1: '',
      staff_phoneNumber1: '',
      staffSalary1: '',
      staffBonus1: '',
      staffDeduction1: '',
      staffSavings1: '',
      staffSavingsPerMonth1: '',
      staffLoan1: '',
      staffLoanPayPerMonth1: '',
      staff_bankAccountName1: '',
      staff_accountNumber1: '',
      staff_bankName1: '',
      staff_commentary1: '',
      createdDate: '',
      staff_salary_increment1: '',
      id: '',
      payable: 0,
      trackingDate: '',
      remainingLoan: '',
      loanPaid: '',
      staffResignationAllowance1: '',
      staffYearAllowanceBalance: '',
      staffEndOfYearAllowanceTxtV: '');

  String? staff_name1,
      staff_position1,
      staff_phoneNumber1,
      staff_bankAccountName1,
      staff_AccountNumber1,
      staff_BankName1,
      staff_commentary1,
      staffSalary1,
      staffBonus1,
      staffDeduction1,
      staffSavings1,
      staffSavingsPerMonth1,
      staffLoan1,
      staffLoanPayPerMonth1,
      staff_salary_increment1,
      trackingDate,
      remainingLoan,
      loanPaid,
      staffResignationAllowance1,
      staffYearAllowanceBalance,
      staffEndOfYearAllowanceTxtV,
      createdDate,
      id;
  var _isInit = true;

  var _initValues = {
    'staff_name1': '',
    'staff_position1': '',
    'staff_phoneNumber1': '',
    'staffSalary1': '',
    'staffBonus1': '',
    'staffDeduction1': '',
    'staffSavings1': '',
    'staffSavingsPerMonth1': '',
    'staffLoan1': '',
    'staffLoanPayPerMonth1': '',
    'staff_bankAccountName1': '',
    'staff_accountNumber1': '',
    'staff_bankName1': '',
    'staff_commentary1': '',
    'createdDate': '',
    'staff_salary_increment1': '',
    'payable': '',
    'trackingDate': '',
    'remainingLoan': '',
    'loanPaid': '',
    'staffResignationAllowance1': '',
    'staffYearAllowanceBalance': '',
    'staffEndOfYearAllowanceTxtV': ''
  };

  Future<void> _deleteStaff(BuildContext context, String staffid) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<PCAS>(context, listen: false).deleteProduct(staffid);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _showErrorMessage(String message, BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Network Error',
                style: TextStyle(color: oxblood),
              ),
              content: Text(
                message,
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

  var staffid;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      staffid = ModalRoute.of(context)!.settings.arguments as Map;
      if (staffid != null) {
        _editedStaff = Provider.of<PCAS>(context, listen: false)
            .findById(staffid['staffid']);
        _initValues = {
          'staff_name1': _editedStaff.staff_name1!,
          'staff_position1': _editedStaff.staff_position1!,
          'staff_phoneNumber1': _editedStaff.staff_phoneNumber1.toString(),
          'staffSalary1': _editedStaff.staffSalary1.toString(),
          'staffBonus1': _editedStaff.staffBonus1.toString(),
          'staffDeduction1': _editedStaff.staffDeduction1.toString(),
          'staffSavings1': _editedStaff.staffSavings1.toString(),
          'staffSavingsPerMonth1':
              _editedStaff.staffSavingsPerMonth1.toString(),
          'staffLoan1': _editedStaff.staffLoan1.toString(),
          'staffLoanPayPerMonth1':
              _editedStaff.staffLoanPayPerMonth1.toString(),
          'staff_bankAccountName1': _editedStaff.staff_bankAccountName1!,
          'staff_accountNumber1': _editedStaff.staff_accountNumber1.toString(),
          'staff_bankName1': _editedStaff.staff_bankName1!,
          'staff_commentary1': _editedStaff.staff_commentary1!,
          'createdDate': _editedStaff.createdDate.toString(),
          'staff_salary_increment1':
              _editedStaff.staff_salary_increment1.toString(),
          'payable': _editedStaff.payable.toString(),
          'trackingDate': _editedStaff.trackingDate!,
          'remainingLoan': _editedStaff.remainingLoan.toString(),
          'loanPaid': _editedStaff.loanPaid.toString(),
          'staffResignationAllowance1':
              _editedStaff.staffResignationAllowance1.toString(),
          'staffYearAllowanceBalance':
              _editedStaff.staffYearAllowanceBalance.toString(),
          'staffEndOfYearAllowanceTxtV':
              _editedStaff.staffEndOfYearAllowanceTxtV!,
          'id': _editedStaff.id!
        };

        //  staffName2.text = _initValues['staff_name1'].toString();
        // staffPosition2.text = _initValues['staff_position1'].toString();
        // staffbasicSalary2.text = _initValues['staffSalary1'].toString();
        // staffRegAllowance2.text =
        //     _initValues['staffResignationAllowance1'].toString();
        // staffPhoneNumber2.text = _initValues['staff_phoneNumber1'].toString();
        // staffStaffBonus2.text = _initValues['staffBonus1'].toString();
        // staffOutstDebt2.text = _initValues['staffDeduction1'].toString();
        // staffStaffTalSavings2.text = _initValues['staffSavings1'].toString();
        // staffStaffSavingPM2.text =
        //     _initValues['staffSavingsPerMonth1'].toString();
        // staffStaffLoan2.text = _initValues['staffLoan1'].toString();
        // staffStaffLoanPM2.text =
        //     _initValues['staffLoanPayPerMonth1'].toString();
        // staffAcctName2.text = _initValues['staff_bankAccountName1'].toString();
        // staffAcctNumber2.text = _initValues['staff_accountNumber1'].toString();
        // staffBank2.text = _initValues['staff_bankName1'].toString();
        // staffComment2.text = _initValues['staff_commentary1'].toString();
        // staffSalaryIncrement2.text =
        //     _initValues['staff_salary_increment1'].toString();
      }
      updateStaffAllowance(_initValues);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> updatestaffInfo(
      Map<String, dynamic> staff, BuildContext ctx) async {
    String? id;

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEE,dd MMM, yy');
    var currentDate = formatter.format(now);
    String trackingDate2 = staff['trackingDate'].toString().isEmpty
        ? currentDate
        : staff['trackingDate'];
    DateTime d1 = new DateFormat("EEE,dd MMM, yy").parse(trackingDate2);
    DateTime d2 = new DateFormat("EEE,dd MMM, yy").parse(currentDate);

    final diff = d2.difference(d1);
    var remainingLoanUpdate;
    // print(diff.inDays);
    id = staff['id'];

    if (staff['remainingLoan'].toString().isNotEmpty) {
      remainingLoanUpdate = double.parse(staff['remainingLoan']);
    }

    if (staff['trackingDate'].toString().isNotEmpty && diff.inDays >= 20) {
      setState(() {
        isLoading = true;
      });

      if (diff.inDays >= 20 &&
          staff['staffLoan1'].toString().isNotEmpty &&
          remainingLoanUpdate > 0) {
        var staffLoanPaid = double.parse(staff['loanPaid']);

        staffLoanPaid += double.parse(staff['staffLoanPayPerMonth1']);
        remainingLoanUpdate -= double.parse(staff['staffLoanPayPerMonth1']);

        final url1 =
            'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
        final response1 = await http.patch(Uri.parse(url1),
            body: json.encode({
              'loanPaid': staffLoanPaid.toString(),
              'remainingLoan': remainingLoanUpdate.toString(),
              'trackingDate': currentDate,
            }));
        if (response1.statusCode >= 400) {
          HttpException(
              'Could not update staff loan details.\n Try again later.');
        }

        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          content: Text(
            '${staff['staff_name1']!} Loan details updated',
            style: const TextStyle(color: oxblood),
          ),
        ));
      } else {
        if (diff.inDays >= 20 && staff['staffLoan1'].toString().isNotEmpty) {
          String payable = staff['payable'].toString();
          int lpayperm = int.parse(staff['staffLoanPayPerMonth1']);
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
            HttpException(
                'Could not update staff loan details.\n Try again later.');
          }

          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            backgroundColor: Colors.transparent,
            content: Text(
              '${staff['staff_name1']!} Loan cleared',
              style: const TextStyle(color: oxblood),
            ),
          ));
        }
      }

      if (diff.inDays >= 20 && staff['staffSavings1'].toString().isNotEmpty) {
        var savings = double.parse(staff['staffSavings1']);
        var savingsPerMth = double.parse(staff['staffSavingsPerMonth1']);
        savings += savingsPerMth;
        final url3 =
            'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
        final response2 = await http.patch(Uri.parse(url3),
            body: json.encode({
              'staffSavings1': savings.toString(),
              'trackingDate': currentDate,
            }));
        if (response2.statusCode >= 400) {
          HttpException(
              'Could not update staff Savings details.\n Try again later.');
        }
      }
      if (diff.inDays >= 20 && staff['staffDeduction1'].toString().isNotEmpty) {
        var payableUpdate = double.parse(staff['payable']);
        payableUpdate += double.parse(staff['staffDeduction1']);

        final url4 =
            'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
        final response4 = await http.patch(Uri.parse(url4),
            body: json.encode({
              'payable': payableUpdate,
              'staffDeduction1': '',
            }));
        if (response4.statusCode >= 400) {
          HttpException(
              'Could not update staff Debt details.\n Try again later.');
        }
      }

      if (diff.inDays >= 20 && staff['staffBonus1'].toString().isNotEmpty) {
        int staffbonus = int.parse(staff['staffBonus1']);

        double payable = double.parse(staff['payable']);
        var payableUpdate = payable.toDouble() - staffbonus.toDouble();

        final url5 =
            'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
        final response5 = await http.patch(Uri.parse(url5),
            body: json.encode({'payable': payableUpdate, 'staffBonus1': ''}));
        if (response5.statusCode >= 400) {
          HttpException(
              'Could not update staff Bonus details.\n Try again later.');
        }
      }

      if (diff.inDays >= 20 &&
          staff['staffResignationAllowance1'].toString().isNotEmpty) {
        var totalPay = (double.parse(staff['staffSalary1']) / 100) * 10;
        var staffAllowanceIncrement =
            totalPay + double.parse(staff['staffResignationAllowance1']);
        final url7 =
            'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id.json';
        final response5 = await http.patch(Uri.parse(url7),
            body: json.encode({
              'staffResignationAllowance1': staffAllowanceIncrement.toString(),
            }));
        if (response5.statusCode >= 400) {
          HttpException(
              'Could not update staff Bonus details.\n Try again later.');
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
                  '${staff['staff_name1']!} DETAIL IS UP TO DATE',
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

    //   print(diff.inDays);

    Navigator.of(ctx).pop();
  }

  Future<void> updateStaffAllowance(Map<String, String> staff) async {
    String? id2;

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEE,dd MMM, yy');
    var currentDate = formatter.format(now);
    String trackingDate = staff['trackingDate']!.toString().isEmpty
        ? currentDate
        : staff['trackingDate']!;
    DateTime d1 = new DateFormat("EEE,dd MMM, yy").parse(trackingDate);
    DateTime d2 = new DateFormat("EEE,dd MMM, yy").parse(currentDate);

    final diff = d2.difference(d1);

    // print(diff.inDays);
    id2 = staff['id'];
    if (diff.inDays >= 365 &&
        staff['staffResignationAllowance1'].toString().isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      double staffYearAllowance =
          double.parse(staff['staffResignationAllowance1']!);
      String staffEndOfTheYearTxtV = "Balance at " + currentDate + ": ";

      final url6 =
          'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id2.json';
      final response5 = await http.patch(Uri.parse(url6),
          body: json.encode({
            'staffYearAllowanceBalance': staffYearAllowance.toString(),
            'staffEndOfYearAllowanceTxtV': staffEndOfTheYearTxtV.toString(),
          }));
      if (response5.statusCode >= 400) {
        HttpException(
            'Could not update staff Bonus details.\n Try again later.');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> disablestaff(
      Map<String, dynamic> staff, BuildContext ctx) async {
    String? id2;
    id2 = staff['id'];
    if (staff['trackingDate'].toString().isNotEmpty) {
      final url1 =
          'https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool/$id2.json';
      final response3 = await http.patch(Uri.parse(url1),
          body: json.encode({
            'trackingDate': '',
          }));
      if (response3.statusCode >= 400) {
        HttpException('Could not disable staff.\n Try again later.');
      }

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: Text(
          '${staff['staff_name1']!} disabled',
          style: const TextStyle(color: oxblood),
        ),
      ));
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text(
                  '${staff['staff_name1']!} HAS ALREADY BEEN DEACTIVATED',
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEE,dd MMM, yy');
    var currentDate = formatter.format(now);
    //  trackingD = formatter.format(now);

    return Placeholder(
      key: staffid['heroTag'],
      child: SafeArea(
        key: null,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: SideMenu(context),
          appBar: AppBar(
            elevation: 0,
            leading: Row(
              children: [
                if (Responsive.isDesktop(context))
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: oxblood,
                      ),
                    ),
                  ),
                if (Responsive.isTablet(context))
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: oxblood,
                      ),
                    ),
                  ),
                if (Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: oxblood,
                      ),
                    ),
                  ),
              ],
            ),
            backgroundColor: Colors.white,
            title: Text(
              '${_initValues['staff_name1'].toString()} PROFILE',
              style: TextStyle(color: oxblood),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text(
                                  'DELETE ${_editedStaff.staff_name1!} DETAILS?',
                                  style: TextStyle(color: oxblood),
                                ),
                                content: Text(
                                  '${_editedStaff.staff_name1!.toLowerCase()} cannot be recovered when deleted!',
                                  style: TextStyle(color: oxblood),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                      child: Text(
                                        'NO',
                                        style: TextStyle(color: oxblood),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        _deleteStaff(context, _editedStaff.id!);
                                      },
                                      child: Text(
                                        'YES',
                                        style: TextStyle(color: oxblood),
                                      ))
                                ],
                              ));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: oxblood,
                    )),
              )
            ],
          ),
          body: isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: oxblood,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${_editedStaff.staff_name1!.toLowerCase()} Account Updating.\nPlease wait...',
                        style: TextStyle(color: oxblood),
                      )
                    ],
                  ),
                )
              : Row(
                  children: [
                    if (Responsive.isDesktop(context))
                      Expanded(key: null, child: SideMenu(context)),
                    Expanded(
                      key: null,
                      flex: 5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (Responsive.isTablet(context))
                              IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  color: oxblood,
                                ),
                              ),
                            Responsive.isDesktop(context)
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 50.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _initValues['staff_name1']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          _initValues['staff_position1']
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)

                                          // TextStyle(
                                          //     color: Colors.black, fontWeight: FontWeight.bold)
                                          ,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            _initValues['staff_phoneNumber1']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _initValues['staff_name1'].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          _initValues['staff_position1']
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis)

                                          // TextStyle(
                                          //     color: Colors.black, fontWeight: FontWeight.bold)
                                          ,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            _initValues['staff_phoneNumber1']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Responsive.isDesktop(context)
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                _initValues[
                                                        'staffEndOfYearAllowanceTxtV']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  _initValues[
                                                          'staffYearAllowanceBalance']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},')
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          color: oxblood,
                                                          fontWeight:
                                                              FontWeight.bold)
                                                  // TextStyle(color: Colors.black),
                                                  ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Resignation Allowance'
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  _initValues[
                                                          'staffResignationAllowance1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          color: oxblood,
                                                          fontWeight:
                                                              FontWeight.bold)
                                                  // TextStyle(
                                                  //     color: Colors.black,
                                                  //     fontWeight: FontWeight.bold),
                                                  ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'CREATED ON: ' +
                                                    _initValues['createdDate']
                                                        .toString()
                                                        .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                currentDate.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, left: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  _initValues[
                                                          'staffEndOfYearAllowanceTxtV']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                  _initValues[
                                                          'staffYearAllowanceBalance']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: TextStyle(
                                                      color: oxblood,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  // Theme.of(context)
                                                  //     .textTheme
                                                  //     .headline5!
                                                  //     .copyWith(
                                                  //         color: oxblood,
                                                  //         fontWeight:
                                                  //             FontWeight.bold)
                                                  // TextStyle(color: Colors.black),
                                                  ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, left: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  'Resign Allowance:'
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Text(
                                                  _initValues[
                                                          'staffResignationAllowance1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: TextStyle(
                                                      color: oxblood,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22)

                                                  // Theme.of(context)
                                                  //     .textTheme
                                                  //     .headline5!
                                                  //     .copyWith(
                                                  //         color: oxblood,
                                                  //         fontWeight:
                                                  //             FontWeight.bold)
                                                  // TextStyle(
                                                  //     color: Colors.black,
                                                  //     fontWeight: FontWeight.bold),
                                                  ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Responsive.isDesktop(context)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'CREATED ON: ' +
                                                        _initValues[
                                                                'createdDate']
                                                            .toString()
                                                            .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    currentDate.toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 25),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'CREATED ON: ' +
                                                          _initValues[
                                                                  'createdDate']
                                                              .toString()
                                                              .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                      softWrap: true,
                                                    ),
                                                    Text(
                                                      currentDate.toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              key: null,
                              child: Responsive.isDesktop(context)
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CardDetailBoard(
                                                  header1: 'Basic Salary',
                                                  text1: _initValues[
                                                          'staffSalary1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},')
                                                      .toString(),
                                                  header2: 'Increment',
                                                  text2: _initValues[
                                                          'staff_salary_increment1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                                CardDetailBoard(
                                                  header1: 'Payable',
                                                  text1: _initValues['payable']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Bonus',
                                                  text2: _initValues[
                                                          'staffBonus1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CardDetailBoard(
                                                  header1: 'Debt',
                                                  text1: _initValues[
                                                          'staffDeduction1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Loan Paid',
                                                  text2: _initValues['loanPaid']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                                CardDetailBoard(
                                                  header1: 'Loan',
                                                  text1: _initValues[
                                                          'staffLoan1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Pay Per Month',
                                                  text2: _initValues[
                                                          'staffLoanPayPerMonth1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CardDetailBoard(
                                                  header1: 'Savings',
                                                  text1: _initValues[
                                                          'staffSavings1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Savings Per Month',
                                                  text2: _initValues[
                                                          'staffSavingsPerMonth1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                                CardDetailBoard(
                                                  header1: 'Bank Details',
                                                  text1: _initValues[
                                                          'staff_bankAccountName1']
                                                      .toString(),
                                                  header2: _initValues[
                                                          'staff_accountNumber1']
                                                      .toString(),
                                                  text2: _initValues[
                                                          'staff_bankName1']
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Text(
                                                    _initValues[
                                                        'staff_commentary1']!,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5, bottom: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CardDetailBoard(
                                                  header1: 'Basic Salary',
                                                  text1: _initValues[
                                                          'staffSalary1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Increment',
                                                  text2: _initValues[
                                                          'staff_salary_increment1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                                CardDetailBoard(
                                                  header1: 'Payable',
                                                  text1: _initValues['payable']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Bonus',
                                                  text2: _initValues[
                                                          'staffBonus1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CardDetailBoard(
                                                  header1: 'Debt',
                                                  text1: _initValues[
                                                          'staffDeduction1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Loan Paid',
                                                  text2: _initValues['loanPaid']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                                CardDetailBoard(
                                                  header1: 'Loan',
                                                  text1: _initValues[
                                                          'staffLoan1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Pay Per Month',
                                                  text2: _initValues[
                                                          'staffLoanPayPerMonth1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CardDetailBoard(
                                                  header1: 'Savings',
                                                  text1: _initValues[
                                                          'staffSavings1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  header2: 'Savings Per Month',
                                                  text2: _initValues[
                                                          'staffSavingsPerMonth1']
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                ),
                                                CardDetailBoard(
                                                  header1: 'Bank Details',
                                                  text1: _initValues[
                                                          'staff_bankAccountName1']
                                                      .toString(),
                                                  header2: _initValues[
                                                          'staff_accountNumber1']
                                                      .toString(),
                                                  text2: _initValues[
                                                          'staff_bankName1']
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 350,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      _initValues[
                                                          'staff_commentary1']!,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ]),
                    )
                  ],
                ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           MoreFunction(
          //             function: () {},
          //             icon: Icon(Icons.edit_note, color: oxblood),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           MoreFunction(
          //             function: () {},
          //             icon: Icon(
          //               Icons.person_add_disabled_outlined,
          //               color: oxblood,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           MoreFunction(
          //             function: () {},
          //             icon: Icon(Icons.print, color: oxblood),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           MoreFunction(
          //             function: () {},
          //             icon: Icon(Icons.update, color: oxblood),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // )
        ),
      ),
    );
  }

  Drawer SideMenu(BuildContext context) {
    return Drawer(
      width: 170,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // DrawerListTIle(
            //     title: 'Edit',
            //     icon: Icon(
            //       Icons.edit_note,
            //       color: Theme.of(context).primaryColor,
            //       size: 16,
            //     ),
            //     press: () async {
            //       if (!Responsive.isDesktop(context))
            //         _scaffoldKey.currentState!.closeDrawer();
            //       await Navigator.of(context)
            //           .pushNamed(UpdateBasicStaff.routeName,
            //               arguments: _editedStaff.id.toString())
            //           .then((value) => setState(() {}));

            //       // Navigator.of(context).pop();
            //     }),
            SizedBox(
              height: 5,
            ),
            DrawerListTIle(
                title: 'Disable',
                icon: Icon(
                  Icons.person_add_disabled_outlined,
                  color: _editedStaff.trackingDate!.toString().isNotEmpty
                      ? Theme.of(context).primaryColor
                      : Colors.red,
                  size: 16,
                ),
                press: () {
                  if (!Responsive.isDesktop(context))
                    _scaffoldKey.currentState!.closeDrawer();
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text(
                              'DISABLE ${_editedStaff.staff_name1!}?',
                              style: TextStyle(color: oxblood),
                            ),
                            content: Text(
                              '${_editedStaff.staff_name1!.toLowerCase()} will be deactivated',
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(),
                                  child: Text(
                                    'NO',
                                    style: TextStyle(color: oxblood),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    await disablestaff(_initValues, context);
                                  },
                                  child: Text(
                                    'OKAY',
                                    style: TextStyle(color: oxblood),
                                  ))
                            ],
                          ));
                }),
            DrawerListTIle(
                title: 'Update',
                icon: Icon(
                  Icons.update,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                press: () {
                  if (!Responsive.isDesktop(context))
                    _scaffoldKey.currentState!.closeDrawer();
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text(
                              'UPDATE ${_editedStaff.staff_name1!} DETAILS?',
                              style: TextStyle(color: oxblood),
                            ),
                            content: Text(
                              '${_editedStaff.staff_name1!.toLowerCase()} (Bonus/Debt/Savings/Loan) will be updated',
                              style: TextStyle(color: oxblood),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(),
                                  child: Text(
                                    'NO',
                                    style: TextStyle(color: oxblood),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    await updatestaffInfo(_initValues, context);
                                  },
                                  child: Text(
                                    'YES',
                                    style: TextStyle(color: oxblood),
                                  ))
                            ],
                          ));
                }),
            DrawerListTIle(
                title: 'Print',
                icon: Icon(
                  Icons.print,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                press: () {
                  if (!Responsive.isDesktop(context))
                    _scaffoldKey.currentState!.closeDrawer();

                  _createPdf(_initValues);
                }),
          ],
        ),
      ),
    );
  }
}

void _createPdf(Map<String, dynamic> initialValue) async {
  final doc = pw.Document();
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('EEE,dd MMM, yy');
  var currentDate = formatter.format(now);

  /// for using an image from assets
  // final image = await imageFromAssetBundle('assets/image.png');

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Center(
              child: pw.Text('PHRANKSTARS BASIC SCHOOL',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(
            height: 35,
          ),
          pw.Text(initialValue['staff_name1'],
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.SizedBox(
            height: 6,
          ),
          pw.Text(initialValue['staff_position1'],
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.SizedBox(
            height: 6,
          ),
          pw.Text(initialValue['staff_phoneNumber1'],
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.SizedBox(
            height: 12,
          ),
          pw.Divider(
            height: 1,
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Center(
              child: pw.Text('Salary Details'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(
            height: 5,
          ),
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Salary:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Payable:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Salary Increment:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Resign Allowance:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                    ]),
                pw.SizedBox(
                  width: 40,
                ),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(initialValue['staffSalary1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(initialValue['payable'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['staff_salary_increment1']
                                  .toString()
                                  .isEmpty
                              ? '___________'
                              : initialValue['staff_salary_increment1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['staffResignationAllowance1']
                                  .toString()
                                  .isEmpty
                              ? '___________'
                              : initialValue['staffResignationAllowance1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ]),
              ]),
          pw.SizedBox(
            height: 12,
          ),
          pw.Divider(
            height: 1,
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Center(
              child: pw.Text('Specials'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(
            height: 5,
          ),
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Bonus:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Debt:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Total Savings:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Savings Per Month:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ]),
                pw.SizedBox(
                  width: 40,
                ),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          initialValue['staffBonus1'].toString().isEmpty
                              ? '___________'
                              : initialValue['staffBonus1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['staffDeduction1'].toString().isEmpty
                              ? '___________'
                              : initialValue['staffDeduction1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['staffSavings1'].toString().isEmpty
                              ? '___________'
                              : initialValue['staffSavings1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['staffSavingsPerMonth1']
                                  .toString()
                                  .isEmpty
                              ? '___________'
                              : initialValue['staffSavingsPerMonth1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ]),
              ]),
          pw.SizedBox(
            height: 12,
          ),
          pw.Divider(
            height: 1,
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Center(
              child: pw.Text('Loan Section'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(
            height: 5,
          ),
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Loan:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Loan Paid:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text('Pay Per Month:',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ]),
                pw.SizedBox(
                  width: 40,
                ),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          initialValue['staffLoan1'].toString().isEmpty
                              ? '___________'
                              : initialValue['staffLoan1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['loanPaid'].toString().isEmpty
                              ? '___________'
                              : initialValue['loanPaid'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                          initialValue['staffLoanPayPerMonth1']
                                  .toString()
                                  .isEmpty
                              ? '___________'
                              : initialValue['staffLoanPayPerMonth1'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ]),
              ]),
          pw.SizedBox(
            height: 15,
          ),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Text(currentDate, style: pw.TextStyle(fontSize: 10))
          ])
        ]);
        // Center
      },
    ),
  ); // Page

  /// print the document using the iOS or Android print service:
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
  if (Platform.isAndroid || Platform.isIOS) {
    /// share the document to other applications:
    await Printing.sharePdf(
        bytes: await doc.save(),
        filename: '${initialValue['staff_name1']} PROFILE.pdf');
  }

  /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
  /// save PDF with Flutter library "path_provider":
  // final output = await getTemporaryDirectory();
  // final file = File('${output.path}/example.pdf');
  // await file.writeAsBytes(await doc.save());
}

class CardDetailBoard extends StatelessWidget {
  final String header1, text1, header2, text2;
  const CardDetailBoard({
    super.key,
    required this.header1,
    required this.text1,
    required this.header2,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: null,
      child: Responsive.isDesktop(context)
          ? Container(
              height: 500,
              width: 400,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: oxblood.withOpacity(0.15), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(header1,
                          style:
                              // TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 30,
                              //     fontWeight: FontWeight.bold),
                              Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Text(text1,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: oxblood,
                                  )

                          //  TextStyle(
                          //     color: oxblood,
                          //     fontSize: 30,
                          //     fontWeight: FontWeight.bold)
                          ,
                          softWrap: true),

                      Divider(
                        thickness: 1.0,
                        color: Colors.green,
                      ),

                      Text(
                        header2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        text2,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: oxblood,
                            )
                        // TextStyle(
                        //     color: oxblood,
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold)
                        ,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: 200,
              width: 310,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: oxblood.withOpacity(0.15), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(header1,
                          style:
                              // TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 30,
                              //     fontWeight: FontWeight.bold),
                              Theme.of(context).textTheme.headline6!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis)),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        text1,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                              color: oxblood,
                            )
                            .copyWith(overflow: TextOverflow.ellipsis)

                        //  TextStyle(
                        //     color: oxblood,
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold)
                        ,
                      ),

                      Divider(
                        thickness: 1.0,
                        color: Colors.green,
                      ),

                      Text(
                        header2,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)
                            .copyWith(overflow: TextOverflow.ellipsis)
                        // TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold)
                        ,
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        text2,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: oxblood,
                            )
                        // TextStyle(
                        //     color: oxblood,
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold)
                        ,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class DrawerListTIle extends StatelessWidget {
  const DrawerListTIle({
    Key? key,
    required this.press,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final VoidCallback press;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: null,
        onTap: press,
        horizontalTitleGap: 0,
        title: Text(title),
        leading: icon

        //  SvgPicture.asset(
        //   svgSrc,
        //   color: Theme.of(context).primaryColor,
        //   height: 16,
        // ),
        );
  }
}
