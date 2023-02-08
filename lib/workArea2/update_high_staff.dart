import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phrankstar/constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:phrankstar/responsive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../models/http_exception.dart';
import 'package:phrankstar/models/high_school_class.dart';
import 'package:phrankstar/models/high_school_class_staff.dart';

class UpdateHighSchoolStaff extends StatefulWidget {
  static const routeName = '/high-school-staff-update';

  @override
  State<UpdateHighSchoolStaff> createState() => _UpdateHighSchoolStaffState();
}

class _UpdateHighSchoolStaffState extends State<UpdateHighSchoolStaff> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController staffName2 = TextEditingController();

  TextEditingController staffPosition2 = TextEditingController();

  TextEditingController staffbasicSalary2 = TextEditingController();

  TextEditingController staffRegAllowance2 = TextEditingController();

  TextEditingController staffPhoneNumber2 = TextEditingController();

  TextEditingController staffStaffBonus2 = TextEditingController();

  TextEditingController staffOutstDebt2 = TextEditingController();

  TextEditingController staffStaffTalSavings2 = TextEditingController();

  TextEditingController staffStaffSavingPM2 = TextEditingController();

  TextEditingController staffStaffLoan2 = TextEditingController();

  TextEditingController staffStaffLoanPM2 = TextEditingController();

  TextEditingController staffAcctName2 = TextEditingController();

  TextEditingController staffAcctNumber2 = TextEditingController();

  TextEditingController staffBank2 = TextEditingController();

  TextEditingController staffComment2 = TextEditingController();

  TextEditingController staffSalaryIncrement2 = TextEditingController();

  var _editedStaff = PHS(
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
      trackingDate,
      staffResignationAllowance1,
      staffYearAllowanceBalance,
      staffEndOfYearAllowanceTxtV,
      createdDate,
      id,
      staffBonus1,
      staffDeduction1,
      staffSavings1,
      staffSavingsPerMonth1,
      staffLoan1,
      staffLoanPayPerMonth1,
      staff_salary_increment1,
      remainingLoan,
      loanPaid;

  double? staffSalary1;

  var _isInit = true;
  var ResignationAllowance, resignation;

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

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final staffid = ModalRoute.of(context)!.settings.arguments as String?;
      if (staffid != null) {
        _editedStaff =
            Provider.of<PHSS>(context, listen: false).findById(staffid);
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

        staffName2.text = _initValues['staff_name1'].toString();
        staffPosition2.text = _initValues['staff_position1'].toString();
        staffbasicSalary2.text = _initValues['staffSalary1'].toString();
        staffRegAllowance2.text =
            _initValues['staffResignationAllowance1'].toString();
        staffPhoneNumber2.text = _initValues['staff_phoneNumber1'].toString();
        staffStaffBonus2.text = _initValues['staffBonus1'].toString();
        staffOutstDebt2.text = _initValues['staffDeduction1'].toString();
        staffStaffTalSavings2.text = _initValues['staffSavings1'].toString();
        staffStaffSavingPM2.text =
            _initValues['staffSavingsPerMonth1'].toString();
        staffStaffLoan2.text = _initValues['staffLoan1'].toString();
        staffStaffLoanPM2.text =
            _initValues['staffLoanPayPerMonth1'].toString();
        staffAcctName2.text = _initValues['staff_bankAccountName1'].toString();
        staffAcctNumber2.text = _initValues['staff_accountNumber1'].toString();
        staffBank2.text = _initValues['staff_bankName1'].toString();
        staffComment2.text = _initValues['staff_commentary1'].toString();
        staffSalaryIncrement2.text =
            _initValues['staff_salary_increment1'].toString();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  var Psalary;

  var loanBalance;

  void submitStaffData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        staff_name1 = staffName2.text;
        staff_position1 = staffPosition2.text;
        staffSalary1 = double.parse(staffbasicSalary2.text);
        staffResignationAllowance1 = staffRegAllowance2.text;
        staffDeduction1 = staffOutstDebt2.text;
        staffSavings1 = staffStaffTalSavings2.text;
        staffSavingsPerMonth1 = staffStaffSavingPM2.text;
        staffLoan1 = staffStaffLoan2.text;
        staffLoanPayPerMonth1 = staffStaffLoanPM2.text;
        staff_AccountNumber1 = staffAcctNumber2.text;
        staff_bankAccountName1 = staffAcctName2.text;
        staff_BankName1 = staffBank2.text;
        staff_commentary1 = staffComment2.text;
        staffBonus1 = staffStaffBonus2.text;
        staff_phoneNumber1 = staffPhoneNumber2.text;
        id = _editedStaff.id;
        trackingDate = _editedStaff.trackingDate;

        if (staffStaffLoanPM2.text.isNotEmpty &&
            staffStaffLoanPM2.text == _editedStaff.staffLoanPayPerMonth1) {
          remainingLoan = _editedStaff.remainingLoan;
          loanPaid = _editedStaff.loanPaid;
        } else {
          remainingLoan = remainingLoan;
          loanPaid = loanPaid;
        }
        if (staffRegAllowance2.text.isNotEmpty &&
            staffRegAllowance2.text == _editedStaff.staffYearAllowanceBalance) {
          staffYearAllowanceBalance = _editedStaff.staffYearAllowanceBalance;
          staffEndOfYearAllowanceTxtV =
              _editedStaff.staffEndOfYearAllowanceTxtV;
        } else {
          staffYearAllowanceBalance = staffYearAllowanceBalance;
          staffEndOfYearAllowanceTxtV = staffEndOfYearAllowanceTxtV;
        }
        createdDate = _editedStaff.createdDate;
        staff_salary_increment1 = staffSalaryIncrement2.text;
      });

      Psalary = Psalary - (double.parse(staffbasicSalary2.text) / 100) * 10;

      if (staffSalaryIncrement2.text.isNotEmpty) {
        double mainBasicSalary = double.parse(staffbasicSalary2.text);
        double psalaryIncrement = double.parse(staffSalaryIncrement2.text);
        mainBasicSalary += psalaryIncrement;
        staffSalary1 = mainBasicSalary.toDouble();
      }
      // Psalary = Psalary + staffPay;

      // id = '';
      // staff_salary_increment1 = '';

      _editedStaff = PHS(
          staff_name1: staff_name1!.toUpperCase(),
          staff_position1: staff_position1!.toUpperCase(),
          staff_phoneNumber1: staff_phoneNumber1!,
          staffSalary1: staffSalary1!.toString(),
          staffBonus1: staffBonus1!,
          staffDeduction1: staffDeduction1!,
          staffSavings1: staffSavings1!,
          staffSavingsPerMonth1: staffSavingsPerMonth1!,
          staffLoan1: staffLoan1!,
          staffLoanPayPerMonth1: staffLoanPayPerMonth1!,
          staff_bankAccountName1: staff_bankAccountName1!.toUpperCase(),
          staff_accountNumber1: staff_AccountNumber1!,
          staff_bankName1: staff_BankName1!.toUpperCase(),
          staff_commentary1: staff_commentary1!.toUpperCase(),
          createdDate: createdDate!,
          staff_salary_increment1: staff_salary_increment1!,
          id: id!,
          payable: Psalary,
          trackingDate: trackingDate!,
          remainingLoan: remainingLoan!,
          loanPaid: loanPaid!,
          staffResignationAllowance1: staffResignationAllowance1!,
          staffYearAllowanceBalance: staffYearAllowanceBalance!,
          staffEndOfYearAllowanceTxtV:
              staffEndOfYearAllowanceTxtV!.toUpperCase());
      setState(() {
        isLoading = true;
      });

      if (_editedStaff.id!.isNotEmpty) {
        await Provider.of<PHSS>(context, listen: false)
            .updateProduct(_editedStaff.id!, _editedStaff);
      } else {
        try {
          await Provider.of<PHSS>(context, listen: false)
              .addNewStaff(_editedStaff);
        } catch (error) {
          return showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  content: Text(
                      'Poor Network Connection.\nCheck Internet Connection And try Again'),
                  title: Text('An error occured!.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Okay')),
                  ],
                );
              });
        }
        // finally {
        //   setState(() {
        //     isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // }
      }
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: Text(
          '${_editedStaff.staff_name1!} updated successfully',
          style: const TextStyle(color: oxblood),
        ),
      ));
      Navigator.of(context).pop();
      // Navigator.of(context)
      //     .pushReplacementNamed(HighSchoolStaffAdmin.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: oxblood,
          ),
        ),
        title: Text(
          'EDIT ${_initValues['staff_name1']} PROFILE',
          style: TextStyle(color: oxblood),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              splashColor: oxblood,
              onPressed: () {
                submitStaffData();
              },
              icon: Icon(Icons.add),
              color: oxblood,
            ),
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
                    '${_editedStaff.staff_name1!} Updating...\nPlease wait.',
                    style: TextStyle(color: oxblood),
                  )
                ],
              ),
            )
          : Container(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // StaffProfile(),
                        // StaffProfileForm(
                        //   title: 'Staff Name',
                        //   hintText: 'Staff Name',
                        // ),
                        // StaffProfileForm(
                        //   title: 'Staff Position',
                        //   hintText: 'Staff Position',
                        // ),

                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Responsive.isDesktop(context)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 300,
                                      right: 300,
                                      top: 16,
                                      bottom: 16),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.name,
                                            controller: staffName2,
                                            onSaved: (value) {
                                              staffName2.text =
                                                  value!.toUpperCase();
                                              // staffName.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ('Staff name is required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Staff Name',
                                              hintText: 'Staff Name',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            controller: staffPosition2,
                                            onSaved: (value) {
                                              staffPosition2.text =
                                                  value!.toUpperCase();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ('Staff Position is required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Staff Position',
                                              hintText: 'Staff Position',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffbasicSalary2,
                                            onSaved: (value) {
                                              staffbasicSalary2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ('Staff Salary is required');
                                              } else {
                                                // Psalary = double.parse(staffSalary1);
                                                Psalary = double.parse(value);
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Basic Salary',
                                              hintText: 'Basic Salary',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffRegAllowance2,
                                            onSaved: (value) {
                                              staffRegAllowance2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                staffResignationAllowance1 = '';
                                                staffYearAllowanceBalance = '';
                                                staffEndOfYearAllowanceTxtV =
                                                    '';
                                              } else {
                                                resignation =
                                                    double.parse(value);
                                                double totalPay =
                                                    (Psalary / 100) * 10;
                                                ResignationAllowance =
                                                    resignation + totalPay;
                                                value = ResignationAllowance
                                                    .toString();

                                                staffEndOfYearAllowanceTxtV =
                                                    'Balance at 30TH DEC,22:';
                                                staffYearAllowanceBalance =
                                                    ResignationAllowance
                                                        .toString();

                                                // staffYearAllowanceBalance =
                                                //     _editedStaff
                                                //         .staffYearAllowanceBalance;
                                                // staffEndOfYearAllowanceTxtV =
                                                //     _editedStaff
                                                //         .staffEndOfYearAllowanceTxtV;
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText:
                                                  'Staff Resignation Allowance',
                                              hintText:
                                                  'Staff Total Resignation Allowance',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            // initialValue: _initValues[
                                            //     'staff_salary_increment1'],
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffSalaryIncrement2,
                                            onSaved: (value) {
                                              staffSalaryIncrement2.text =
                                                  value!;
                                              // staffSalaryIncrement.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                staff_salary_increment1 = '';
                                              } else if (value.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isEmpty) {
                                                return ('Staff Salary required');
                                              } else {
                                                var PsalaryIncrement =
                                                    double.parse(value);
                                                Psalary += PsalaryIncrement;
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Salary Increment',
                                              hintText: 'Salary Increment',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'OPTIONAL DETAILS',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(color: oxblood),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffPhoneNumber2,
                                            onSaved: (value) {
                                              staffPhoneNumber2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Phone Number',
                                              hintText: 'Phone Number',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffBonus2,
                                            onSaved: (value) {
                                              staffStaffBonus2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                var bonus = double.parse(value);
                                                Psalary += bonus;
                                              } else {
                                                value = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Bonus',
                                              hintText: 'Month Bonus?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffOutstDebt2,
                                            onSaved: (value) {
                                              staffOutstDebt2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                double debt =
                                                    double.parse(value);
                                                Psalary -= debt;
                                              } else {
                                                value = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Outstanding Debts',
                                              hintText:
                                                  'Month Outstanding Debt?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffTalSavings2,
                                            onSaved: (value) {
                                              staffStaffTalSavings2.text =
                                                  value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffSavingPM2
                                                      .text.isNotEmpty) {
                                                // Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffSavingPM.text.isEmpty) {
                                              //   return ("Staff Savings Per Month required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffSavingPM2
                                                      .text.isNotEmpty) {
                                                return ("Staff Total Savings required");
                                              } else {
                                                value = "";
                                                // staffSavingsPerMonth1 = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText:
                                                  'Total Savings Currently',
                                              hintText: 'Savings Currently',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            controller: staffStaffSavingPM2,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onSaved: (value) {
                                              staffStaffSavingPM2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffTalSavings2
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffTalSavings.text.isEmpty) {
                                              //   return ("Staff Total Savings required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffTalSavings2
                                                      .text.isNotEmpty) {
                                                return ("Staff Savings Per Month required");
                                              } else {
                                                value = "";
                                                // staffSavingsPerMonth1 = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Savings per Month',
                                              hintText:
                                                  'Staff Savings per Month',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'LOAN SECTION',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(color: oxblood),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffLoan2,
                                            onSaved: (value) {
                                              staffStaffLoan2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoanPM2
                                                      .text.isNotEmpty) {
                                                double dstaffLoan =
                                                    double.parse(value);
                                                double dstaffLoanPayPerMonth =
                                                    double.parse(
                                                        staffStaffLoanPM2.text);
                                                loanBalance = dstaffLoan -
                                                    dstaffLoanPayPerMonth;
                                                remainingLoan =
                                                    loanBalance!.toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoanPM.text.isEmpty) {
                                              //   return ("Fill Staff Loan Per Month");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoanPM2
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Amount required");
                                              } else {
                                                value = "";
                                                // staffLoanPayPerMonth1 = "";
                                                remainingLoan = '';
                                                loanPaid = '';
                                              }

                                              // if (value!.isEmpty) {
                                              //   return ('Staff Position is required');
                                              // }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Loan',
                                              hintText: 'Staff Loan?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffLoanPM2,
                                            onSaved: (value) {
                                              staffStaffLoanPM2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoan2
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                double dstaffLoanPayPerMonth =
                                                    double.parse(value);
                                                Psalary = Psalary -
                                                    dstaffLoanPayPerMonth;
                                                loanPaid = dstaffLoanPayPerMonth
                                                    .toString();
                                                // double dstaffLoan = double.parse(value);
                                                // double dstaffLoanPayPerMonth =
                                                //     double.parse(staffStaffLoanPM.text);
                                                // loanBalance = dstaffLoan - dstaffLoanPayPerMonth;
                                                // Psalary = Psalary - dstaffLoanPayPerMonth;
                                                // remainingLoan = loanBalance.toString();
                                                // loanPaid = dstaffLoanPayPerMonth.toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoan.text.isEmpty) {
                                              //   return ("Staff Loan required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoan2
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Pay Per Month required");
                                              } else {
                                                value = "";
                                                // staffLoanPayPerMonth1 = "";
                                                // remainingLoan = "";
                                                // loanPaid = "";
                                              }

                                              // if (value!.isEmpty) {
                                              //   return ('Staff Position is required');
                                              // }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Loan pay per Month',
                                              hintText:
                                                  'Staff Loan pay per Month',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'BANK DETAILS',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(color: oxblood),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.name,
                                            controller: staffAcctName2,
                                            onSaved: (value) {
                                              staffAcctName2.text =
                                                  value!.toUpperCase();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Account name',
                                              hintText: 'Bank account name',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffAcctNumber2,
                                            onSaved: (value) {
                                              staffAcctNumber2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              } else if (value.length < 10) {
                                                return ("Invalid account number");
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Account number',
                                              hintText: 'Bank account number',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            controller: staffBank2,
                                            onSaved: (value) {
                                              staffBank2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Bank Name',
                                              hintText: 'Bank',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            maxLines: 2,
                                            maxLength: 100,
                                            keyboardType:
                                                TextInputType.multiline,
                                            controller: staffComment2,
                                            onSaved: (value) {
                                              staffComment2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Commentary',
                                              hintText:
                                                  'Any comment about staff?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 16, bottom: 16),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.name,
                                            controller: staffName2,
                                            onSaved: (value) {
                                              staffName2.text =
                                                  value!.toUpperCase();
                                              // staffName.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ('Staff name is required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Staff Name',
                                              hintText: 'Staff Name',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            controller: staffPosition2,
                                            onSaved: (value) {
                                              staffPosition2.text =
                                                  value!.toUpperCase();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ('Staff Position is required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Staff Position',
                                              hintText: 'Staff Position',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffbasicSalary2,
                                            onSaved: (value) {
                                              staffbasicSalary2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ('Staff Salary is required');
                                              } else {
                                                // Psalary = double.parse(staffSalary1);
                                                Psalary = double.parse(value);
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Basic Salary',
                                              hintText: 'Basic Salary',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffRegAllowance2,
                                            onSaved: (value) {
                                              staffRegAllowance2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                staffResignationAllowance1 = '';
                                                staffYearAllowanceBalance = '';
                                                staffEndOfYearAllowanceTxtV =
                                                    '';
                                              } else {
                                                resignation =
                                                    double.parse(value);
                                                double totalPay =
                                                    (Psalary / 100) * 10;
                                                ResignationAllowance =
                                                    resignation + totalPay;
                                                value = ResignationAllowance
                                                    .toString();

                                                staffEndOfYearAllowanceTxtV =
                                                    'Balance at 31TH JAN,23:';
                                                staffYearAllowanceBalance =
                                                    ResignationAllowance
                                                        .toString();

                                                // staffYearAllowanceBalance =
                                                //     _editedStaff
                                                //         .staffYearAllowanceBalance;
                                                // staffEndOfYearAllowanceTxtV =
                                                //     _editedStaff
                                                //         .staffEndOfYearAllowanceTxtV;
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText:
                                                  'Staff Resignation Allowance',
                                              hintText:
                                                  'Staff Total Resignation Allowance',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            // initialValue: _initValues[
                                            //     'staff_salary_increment1'],
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffSalaryIncrement2,
                                            onSaved: (value) {
                                              staffSalaryIncrement2.text =
                                                  value!;
                                              // staffSalaryIncrement.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                staff_salary_increment1 = '';
                                              } else if (value.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isEmpty) {
                                                return ('Staff Salary required');
                                              } else {
                                                var PsalaryIncrement =
                                                    double.parse(value);
                                                Psalary += PsalaryIncrement;
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Salary Increment',
                                              hintText: 'Salary Increment',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text('OPTIONAL DETAILS',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        color: oxblood,
                                                        fontSize: 14)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffPhoneNumber2,
                                            onSaved: (value) {
                                              staffPhoneNumber2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Phone Number',
                                              hintText: 'Phone Number',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffBonus2,
                                            onSaved: (value) {
                                              staffStaffBonus2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                var bonus = double.parse(value);
                                                Psalary += bonus;
                                              } else {
                                                value = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Bonus',
                                              hintText: 'Month Bonus?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffOutstDebt2,
                                            onSaved: (value) {
                                              staffOutstDebt2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                double debt =
                                                    double.parse(value);
                                                Psalary -= debt;
                                              } else {
                                                value = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Outstanding Debts',
                                              hintText:
                                                  'Month Outstanding Debt?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffTalSavings2,
                                            onSaved: (value) {
                                              staffStaffTalSavings2.text =
                                                  value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffSavingPM2
                                                      .text.isNotEmpty) {
                                                // Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffSavingPM.text.isEmpty) {
                                              //   return ("Staff Savings Per Month required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffSavingPM2
                                                      .text.isNotEmpty) {
                                                return ("Staff Total Savings required");
                                              } else {
                                                value = "";
                                                // staffSavingsPerMonth1 = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText:
                                                  'Total Savings Currently',
                                              hintText: 'Savings Currently',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            controller: staffStaffSavingPM2,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onSaved: (value) {
                                              staffStaffSavingPM2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffTalSavings2
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffTalSavings.text.isEmpty) {
                                              //   return ("Staff Total Savings required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffTalSavings2
                                                      .text.isNotEmpty) {
                                                return ("Staff Savings Per Month required");
                                              } else {
                                                value = "";
                                                // staffSavingsPerMonth1 = "";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Savings per Month',
                                              hintText:
                                                  'Staff Savings per Month',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'LOAN SECTION',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: oxblood,
                                                      fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffLoan2,
                                            onSaved: (value) {
                                              staffStaffLoan2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoanPM2
                                                      .text.isNotEmpty) {
                                                double dstaffLoan =
                                                    double.parse(value);
                                                double dstaffLoanPayPerMonth =
                                                    double.parse(
                                                        staffStaffLoanPM2.text);
                                                loanBalance = dstaffLoan -
                                                    dstaffLoanPayPerMonth;
                                                remainingLoan =
                                                    loanBalance!.toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoanPM.text.isEmpty) {
                                              //   return ("Fill Staff Loan Per Month");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoanPM2
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Amount required");
                                              } else {
                                                value = "";
                                                // staffLoanPayPerMonth1 = "";
                                                remainingLoan = '';
                                                loanPaid = '';
                                              }

                                              // if (value!.isEmpty) {
                                              //   return ('Staff Position is required');
                                              // }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Loan',
                                              hintText: 'Staff Loan?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffLoanPM2,
                                            onSaved: (value) {
                                              staffStaffLoanPM2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoan2
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary2
                                                      .text.isNotEmpty) {
                                                double dstaffLoanPayPerMonth =
                                                    double.parse(value);
                                                Psalary = Psalary -
                                                    dstaffLoanPayPerMonth;
                                                loanPaid = dstaffLoanPayPerMonth
                                                    .toString();
                                                // double dstaffLoan = double.parse(value);
                                                // double dstaffLoanPayPerMonth =
                                                //     double.parse(staffStaffLoanPM.text);
                                                // loanBalance = dstaffLoan - dstaffLoanPayPerMonth;
                                                // Psalary = Psalary - dstaffLoanPayPerMonth;
                                                // remainingLoan = loanBalance.toString();
                                                // loanPaid = dstaffLoanPayPerMonth.toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoan.text.isEmpty) {
                                              //   return ("Staff Loan required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoan2
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Pay Per Month required");
                                              } else {
                                                value = "";
                                                // staffLoanPayPerMonth1 = "";
                                                // remainingLoan = "";
                                                // loanPaid = "";
                                              }

                                              // if (value!.isEmpty) {
                                              //   return ('Staff Position is required');
                                              // }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Loan pay per Month',
                                              hintText:
                                                  'Staff Loan pay per Month',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'BANK DETAILS',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: oxblood,
                                                      fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.name,
                                            controller: staffAcctName2,
                                            onSaved: (value) {
                                              staffAcctName2.text =
                                                  value!.toUpperCase();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Account name',
                                              hintText: 'Bank account name',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffAcctNumber2,
                                            onSaved: (value) {
                                              staffAcctNumber2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              } else if (value.length < 10) {
                                                return ("Invalid account number");
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Account number',
                                              hintText: 'Bank account number',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            controller: staffBank2,
                                            onSaved: (value) {
                                              staffBank2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Bank Name',
                                              hintText: 'Bank',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            maxLines: 2,
                                            maxLength: 100,
                                            keyboardType:
                                                TextInputType.multiline,
                                            controller: staffComment2,
                                            onSaved: (value) {
                                              staffComment2.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                value = '';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              iconColor: oxblood,
                                              labelText: 'Commentary',
                                              hintText:
                                                  'Any comment about staff?',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                        )
                      ]),
                ),
              ),
            ),
    ));
  }
}
