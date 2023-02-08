import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phrankstar/constants.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:phrankstar/models/basic_school_class.dart';
import 'package:http/http.dart' as http;
import 'package:phrankstar/models/basic_school_class_staff.dart';
import 'package:phrankstar/responsive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class AddBasicStaff extends StatefulWidget {
  static const routeName = '/Add-BasicStaff';
  AddBasicStaff({Key? key}) : super(key: key);

  @override
  State<AddBasicStaff> createState() => _AddBasicStaffState();
}

class _AddBasicStaffState extends State<AddBasicStaff> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController staffName = TextEditingController();

  TextEditingController staffPosition = TextEditingController();

  TextEditingController staffbasicSalary = TextEditingController();

  TextEditingController staffRegAllowance = TextEditingController();

  TextEditingController staffPhoneNumber = TextEditingController();

  TextEditingController staffStaffBonus = TextEditingController();

  TextEditingController staffOutstDebt = TextEditingController();

  TextEditingController staffStaffTalSavings = TextEditingController();

  TextEditingController staffStaffSavingPM = TextEditingController();

  TextEditingController staffStaffLoan = TextEditingController();

  TextEditingController staffStaffLoanPM = TextEditingController();

  TextEditingController staffAcctName = TextEditingController();

  TextEditingController staffAcctNumber = TextEditingController();

  TextEditingController staffBank = TextEditingController();

  TextEditingController staffComment = TextEditingController();

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
      staffYearAllowanceBalance1,
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final staffid = ModalRoute.of(context)!.settings.arguments as String?;
      if (staffid != null) {
        _editedStaff =
            Provider.of<PCAS>(context, listen: false).findById(staffid);
        _initValues = {
          'staff_name1': _editedStaff.staff_name1.toString(),
          'staff_position1': _editedStaff.staff_position1.toString(),
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
          'staff_bankAccountName1':
              _editedStaff.staff_bankAccountName1.toString(),
          'staff_accountNumber1': _editedStaff.staff_accountNumber1.toString(),
          'staff_bankName1': _editedStaff.staff_bankName1.toString(),
          'staff_commentary1': _editedStaff.staff_commentary1.toString(),
          'createdDate': _editedStaff.createdDate.toString(),
          'staff_salary_increment1':
              _editedStaff.staff_salary_increment1.toString(),
          'payable': _editedStaff.payable.toString(),
          'trackingDate': _editedStaff.trackingDate.toString(),
          'remainingLoan': _editedStaff.remainingLoan.toString(),
          'loanPaid': _editedStaff.loanPaid.toString(),
          'staffResignationAllowance1':
              _editedStaff.staffResignationAllowance1.toString(),
          'staffYearAllowanceBalance':
              _editedStaff.staffYearAllowanceBalance.toString(),
          'staffEndOfYearAllowanceTxtV':
              _editedStaff.staffEndOfYearAllowanceTxtV.toString()
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  var Psalary;

  var loanBalance;
  bool isLoading = false;

  void submitStaffData() async {
    // staffSalary1 = staff_Salary1.getText().toString().replaceAll(",", "");
    // staffBonus1 = staff_bonus1.getText().toString().replaceAll(",", "");
    // staffDeduction1 = staff_deduction1.getText().toString().replaceAll(",", "");
    // staffSavings1 = staff_savings1.getText().toString().replaceAll(",", "");
    // staffSavingsPerMonth1 = staff_savings_per_month1.getText().toString().replaceAll(",", "");
    // staffLoan1 = staff_loan1.getText().toString().replaceAll(",", "");
    // staffLoanPayPerMonth1 = staff_loan_pay_per_month1.getText().toString().replaceAll(",", "");
    // staffResignationAllowance1 = staff_resignation_allowance1.getText().toString().replaceAll(",", "");
    // staff_salary_increment1 ="";

    if (_formKey.currentState!.validate()) {
      // setState(() {
      staff_name1 = staffName.text.toString();
      staff_position1 = staffPosition.text.toString();
      staffSalary1 = staffbasicSalary.text.toString();
      staffResignationAllowance1 = staffRegAllowance.text.toString();
      staffDeduction1 = staffOutstDebt.text.toString();
      staffSavings1 = staffStaffTalSavings.text.toString();
      staffSavingsPerMonth1 = staffStaffSavingPM.text.toString();
      staffLoan1 = staffStaffLoan.text.toString();
      staffLoanPayPerMonth1 = staffStaffLoanPM.text.toString();
      staff_AccountNumber1 = staffAcctNumber.text.toString();
      staff_bankAccountName1 = staffAcctName.text.toString();
      staff_BankName1 = staffBank.text.toString();
      staff_commentary1 = staffComment.text.toString();
      staffBonus1 = staffStaffBonus.text.toString();
      staff_phoneNumber1 = staffPhoneNumber.text.toString();

      Psalary = Psalary - (double.parse(staffbasicSalary.text) / 100) * 10;
      // Psalary = Psalary + staffPay;

      id = '';
      staff_salary_increment1 = '';

      _editedStaff = PCA(
          staff_name1: staff_name1!.toUpperCase(),
          staff_position1: staff_position1!.toUpperCase(),
          staff_phoneNumber1: staff_phoneNumber1!,
          staffSalary1: staffSalary1!,
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
          staffYearAllowanceBalance: staffYearAllowanceBalance1!,
          staffEndOfYearAllowanceTxtV:
              staffEndOfYearAllowanceTxtV!.toUpperCase());

      // addToFireStore(
      //     staff_name1!,
      //     staff_position1!,
      //     staff_phoneNumber1!,
      //     staffSalary1!,
      //     staffBonus1!,
      //     staffDeduction1!,
      //     staffSavings1!,
      //     staffSavingsPerMonth1!,
      //     staffLoan1!,
      //     staffLoanPayPerMonth1!,
      //     staff_bankAccountName1!,
      //     staff_AccountNumber1!,
      //     staff_BankName1!,
      //     staff_commentary1!,
      //     createdDate!,
      //     Psalary,
      //     staff_salary_increment1!,
      //     id!,
      //     trackingDate!,
      //     remainingLoan!,
      //     loanPaid!,
      //     staffResignationAllowance1!,
      //     staffYearAllowanceBalance!,
      //     staffEndOfYearAllowanceTxtV!);
      // // });

      setState(() {
        isLoading = true;
      });

      if (_editedStaff.id!.isNotEmpty) {
        await Provider.of<PCAS>(context, listen: false)
            .updateProduct(_editedStaff.id!, _editedStaff);
      } else {
        try {
          await Provider.of<PCAS>(context, listen: false)
              .addNewStaff(_editedStaff);
        } catch (error) {
          await showDialog(
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
          '${_editedStaff.staff_name1!} added successfully',
          style: const TextStyle(color: oxblood),
        ),
      ));
      Navigator.of(context).pop();
    }
  }

  // Future addToFireStore(
  //     String staff_name1,
  //     String staff_position1,
  //     String staff_phoneNumber1,
  //     String staffSalary1,
  //     String staffBonus1,
  //     String staffDeduction1,
  //     String staffSavings1,
  //     String staffSavingsPerMonth1,
  //     String staffLoan1,
  //     String staffLoanPayPerMonth1,
  //     String staff_bankAccountName1,
  //     String staff_accountNumber1,
  //     String staff_bankName1,
  //     String staff_commentary1,
  //     String createdDate,
  //     double payable,
  //     String staff_salary_increment1,
  //     String id,
  //     String trackingDate,
  //     String remainingLoan,
  //     String loanPaid,
  //     String staffResignationAllowance1,
  //     String staffYearAllowanceBalance,
  //     String staffEndOfYearAllowanceTxtV) async {
  //   // Firestore fbstore1 = Firestore.initialize('phrankstarmanagement');

  //   // final fbstore = FirebaseFirestore.instance.collection('BasicSchool').doc();
  //   PCA pca = PCA();

  //   pca.staff_name1 = staff_name1;
  //   pca.staff_position1 = staff_position1;
  //   pca.staff_phoneNumber1 = staff_phoneNumber1;
  //   pca.staffSalary1 = staffSalary1;
  //   pca.staffBonus1 = staffBonus1;
  //   pca.staffDeduction1 = staffDeduction1;
  //   pca.staffSavings1 = staffSavings1;
  //   pca.staffSavingsPerMonth1 = staffSavingsPerMonth1;
  //   pca.staffLoan1 = staffLoan1;
  //   pca.staffLoanPayPerMonth1 = staffLoanPayPerMonth1;
  //   pca.staff_bankAccountName1 = staff_bankAccountName1;
  //   pca.staff_accountNumber1 = staff_accountNumber1;
  //   pca.staff_bankName1 = staff_bankName1;
  //   pca.staff_commentary1 = staff_commentary1;
  //   pca.createdDate = createdDate;
  //   pca.payable = payable;
  //   pca.staff_salary_increment1 = staff_salary_increment1;
  //   pca.trackingDate = trackingDate;
  //   pca.remainingLoan = remainingLoan;
  //   pca.loanPaid = loanPaid;
  //   pca.staffResignationAllowance1 = staffResignationAllowance1;
  //   pca.staffYearAllowanceBalance = staffYearAllowanceBalance;
  //   pca.staffEndOfYearAllowanceTxtV = staffEndOfYearAllowanceTxtV;
  //   pca.id = '';

  //   // await fbstore.set(pca.toMap()).whenComplete(() {
  //   //   Fluttertoast.showToast(msg: '$staff_name1 successfully added');
  //   //   Navigator.of(context).pop();
  //   // }).catchError((e) {
  //   //   Fluttertoast.showToast(msg: e!.message);
  //   //   Navigator.of(context).pop();
  //   // });

  //   final response = await http
  //       .post(
  //           Uri.parse(
  //               "https://phrankstarmanagement-default-rtdb.firebaseio.com/BasicSchool.json"),
  //           body: json.encode(pca.toMap()))
  //       .then((response) {
  //     pca.id = json.decode(response.body)['name'];
  //     Fluttertoast.showToast(
  //         msg: '${pca.staff_name1} added successfully added');
  //     Navigator.of(context).pop();
  //   }).catchError((e) {
  //     Fluttertoast.showToast(msg: e);
  //     throw HttpException(e);
  //   });

  //   // final responseData = json.decode(response.body);
  //   // if (responseData['error'] != null) {
  //   //   Fluttertoast.showToast(msg: responseData['error']['message']);
  //   //   throw HttpException(responseData['error']['message']);
  //   // } else {
  //   //   Fluttertoast.showToast(
  //   //       msg: '${pca.staff_name1} added successfully added');
  //   //   Navigator.of(context).pop();
  //   // }
  //   // setState(() {
  //   //   userProfile.add(Profile(
  //   //     firstName: firstNameController.text,
  //   //     lastName: lastNameController.text,
  //   //     email: emailController.text,
  //   //   ));
  //   // });
  // }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

    staff_name1 = staffName.text;
    staff_position1 = staffPosition.text;
    staffSalary1 = staffbasicSalary.text;
    staffResignationAllowance1 = staffRegAllowance.text;
    staffDeduction1 = staffOutstDebt.text;
    staffSavings1 = staffStaffTalSavings.text;
    staffSavingsPerMonth1 = staffStaffSavingPM.text;
    staffLoan1 = staffStaffLoan.text;
    staffLoanPayPerMonth1 = staffStaffLoanPM.text;
    staff_AccountNumber1 = staffAcctNumber.text;
    staff_bankAccountName1 = staffAcctName.text;
    staff_BankName1 = staffBank.text;
    staff_commentary1 = staffComment.text;
    staffBonus1 = staffStaffBonus.text;
    staff_phoneNumber1 = staffPhoneNumber.text;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEE,dd MMM, yy');
    createdDate = formatter.format(now);
    trackingDate = formatter.format(now);

    // Psalary = staffbasicSalary.text;

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
          'Add Basic School Staff'.toUpperCase(),
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
                  Text('Adding $staff_name1\nPlease wait.')
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
                                            controller: staffName,
                                            onSaved: (value) {
                                              staffName.text =
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
                                            controller: staffPosition,
                                            onSaved: (value) {
                                              staffPosition.text =
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
                                            controller: staffbasicSalary,
                                            onSaved: (value) {
                                              staffbasicSalary.text = value!;
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
                                            controller: staffRegAllowance,
                                            onSaved: (value) {
                                              staffRegAllowance.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                staffResignationAllowance1 = '';
                                                staffYearAllowanceBalance1 = '';
                                                staffEndOfYearAllowanceTxtV =
                                                    '';
                                              } else {
                                                staffEndOfYearAllowanceTxtV =
                                                    'Balance at 31TH JAN,23:';
                                                var resignation =
                                                    double.parse(value);
                                                double totalPay =
                                                    (Psalary / 100) * 10;
                                                var ResignationAllowance =
                                                    resignation + totalPay;
                                                value = ResignationAllowance
                                                    .toString();
                                                staffYearAllowanceBalance1 =
                                                    ResignationAllowance
                                                        .toString();
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
                                        // staffSavings1 = staffStaffTalSavings.text;
                                        // staffSavingsPerMonth1 = staffStaffSavingPM.text;
                                        // staffLoan1 = staffStaffLoan.text;
                                        // staffLoanPayPerMonth1 = staffStaffLoanPM.text;
                                        // staff_AccountNumber1 = staffAcctNumber.text;
                                        // staff_bankAccountName1 = staffAcctName.text;
                                        // staff_BankName1 = staffBank.text;
                                        // staff_commentary1 = staffComment.text;
                                        // staffBonus1 = staffStaffBonus.text;
                                        // staff_phoneNumber1 = staffPhoneNumber.text;
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
                                            controller: staffPhoneNumber,
                                            onSaved: (value) {
                                              staffPhoneNumber.text = value!;
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
                                            controller: staffStaffBonus,
                                            onSaved: (value) {
                                              staffStaffBonus.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary
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
                                            controller: staffOutstDebt,
                                            onSaved: (value) {
                                              staffOutstDebt.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary
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
                                            controller: staffStaffTalSavings,
                                            onSaved: (value) {
                                              staffStaffTalSavings.text =
                                                  value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffSavingPM
                                                      .text.isNotEmpty) {
                                                // Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffSavingPM.text.isEmpty) {
                                              //   return ("Staff Savings Per Month required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffSavingPM
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
                                            controller: staffStaffSavingPM,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onSaved: (value) {
                                              staffStaffSavingPM.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffTalSavings
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary
                                                      .text.isNotEmpty) {
                                                Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffTalSavings.text.isEmpty) {
                                              //   return ("Staff Total Savings required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffTalSavings
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
                                        // staffLoanPayPerMonth1 = staffStaffLoanPM.text;
                                        // staff_AccountNumber1 = staffAcctNumber.text;
                                        // staff_bankAccountName1 = staffAcctName.text;
                                        // staff_BankName1 = staffBank.text;
                                        // staff_commentary1 = staffComment.text;
                                        // staffBonus1 = staffStaffBonus.text;
                                        TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: staffStaffLoan,
                                            onSaved: (value) {
                                              staffStaffLoan.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoanPM
                                                      .text.isNotEmpty) {
                                                // double dstaffLoan =
                                                //     double.parse(value);
                                                // double dstaffLoanPayPerMonth =
                                                //     double.parse(
                                                //         staffStaffLoanPM.text);
                                                // loanBalance = dstaffLoan -
                                                //     dstaffLoanPayPerMonth;
                                                // Psalary -= dstaffLoanPayPerMonth;
                                                // remainingLoan = (dstaffLoan -
                                                //         dstaffLoanPayPerMonth)
                                                //     .toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoanPM.text.isEmpty) {
                                              //   return ("Fill Staff Loan Per Month");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoanPM
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Amount required");
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
                                            controller: staffStaffLoanPM,
                                            onSaved: (value) {
                                              staffStaffLoanPM.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoan
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary
                                                      .text.isNotEmpty) {
                                                double dstaffLoanPayPerMonth =
                                                    double.parse(value);
                                                Psalary -=
                                                    dstaffLoanPayPerMonth;
                                                loanPaid = dstaffLoanPayPerMonth
                                                    .toString();

                                                double dstaffLoan =
                                                    double.parse(
                                                        staffStaffLoan.text);

                                                loanBalance = dstaffLoan -
                                                    dstaffLoanPayPerMonth;
                                                // double loanbal = dstaffLoan -
                                                //       dstaffLoanPayPerMonth;
                                                remainingLoan =
                                                    loanBalance.toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoan.text.isEmpty) {
                                              //   return ("Staff Loan required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoan
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Pay Per Month required");
                                              } else {
                                                value = "";
                                                staffLoanPayPerMonth1 = "";
                                                remainingLoan = "";
                                                loanPaid = "";
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
                                            controller: staffAcctName,
                                            onSaved: (value) {
                                              staffAcctName.text =
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
                                            controller: staffAcctNumber,
                                            onSaved: (value) {
                                              staffAcctNumber.text = value!;
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
                                            controller: staffBank,
                                            onSaved: (value) {
                                              staffBank.text =
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
                                            controller: staffComment,
                                            onSaved: (value) {
                                              staffComment.text = value!;
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
                                            controller: staffName,
                                            onSaved: (value) {
                                              staffName.text =
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
                                            controller: staffPosition,
                                            onSaved: (value) {
                                              staffPosition.text =
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
                                            controller: staffbasicSalary,
                                            onSaved: (value) {
                                              staffbasicSalary.text = value!;
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
                                            controller: staffRegAllowance,
                                            onSaved: (value) {
                                              staffRegAllowance.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                staffResignationAllowance1 = '';
                                                staffYearAllowanceBalance1 = '';
                                                staffEndOfYearAllowanceTxtV =
                                                    '';
                                              } else {
                                                staffEndOfYearAllowanceTxtV =
                                                    'Bal. at 30TH DEC,22:';
                                                var resignation =
                                                    double.parse(value);
                                                double totalPay =
                                                    (Psalary / 100) * 10;
                                                var ResignationAllowance =
                                                    resignation + totalPay;
                                                value = ResignationAllowance
                                                    .toString();
                                                staffYearAllowanceBalance1 =
                                                    ResignationAllowance
                                                        .toString();
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
                                        Row(
                                          children: [
                                            Text(
                                              'OPTIONAL DETAILS',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: oxblood,
                                                      fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        // staffSavings1 = staffStaffTalSavings.text;
                                        // staffSavingsPerMonth1 = staffStaffSavingPM.text;
                                        // staffLoan1 = staffStaffLoan.text;
                                        // staffLoanPayPerMonth1 = staffStaffLoanPM.text;
                                        // staff_AccountNumber1 = staffAcctNumber.text;
                                        // staff_bankAccountName1 = staffAcctName.text;
                                        // staff_BankName1 = staffBank.text;
                                        // staff_commentary1 = staffComment.text;
                                        // staffBonus1 = staffStaffBonus.text;
                                        // staff_phoneNumber1 = staffPhoneNumber.text;
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
                                            controller: staffPhoneNumber,
                                            onSaved: (value) {
                                              staffPhoneNumber.text = value!;
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
                                            controller: staffStaffBonus,
                                            onSaved: (value) {
                                              staffStaffBonus.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary
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
                                            controller: staffOutstDebt,
                                            onSaved: (value) {
                                              staffOutstDebt.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffbasicSalary
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
                                            controller: staffStaffTalSavings,
                                            onSaved: (value) {
                                              staffStaffTalSavings.text =
                                                  value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffSavingPM
                                                      .text.isNotEmpty) {
                                                // Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffSavingPM.text.isEmpty) {
                                              //   return ("Staff Savings Per Month required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffSavingPM
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
                                            controller: staffStaffSavingPM,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onSaved: (value) {
                                              staffStaffSavingPM.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffTalSavings
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary
                                                      .text.isNotEmpty) {
                                                Psalary -= double.parse(value);
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffTalSavings.text.isEmpty) {
                                              //   return ("Staff Total Savings required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffTalSavings
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
                                            controller: staffStaffLoan,
                                            onSaved: (value) {
                                              staffStaffLoan.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoanPM
                                                      .text.isNotEmpty) {
                                                // double dstaffLoan =
                                                //     double.parse(value);
                                                // double dstaffLoanPayPerMonth =
                                                //     double.parse(
                                                //         staffStaffLoanPM.text);
                                                // loanBalance = dstaffLoan -
                                                //     dstaffLoanPayPerMonth;
                                                // Psalary -= dstaffLoanPayPerMonth;
                                                // remainingLoan = (dstaffLoan -
                                                //         dstaffLoanPayPerMonth)
                                                //     .toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoanPM.text.isEmpty) {
                                              //   return ("Fill Staff Loan Per Month");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoanPM
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Amount required");
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
                                            controller: staffStaffLoanPM,
                                            onSaved: (value) {
                                              staffStaffLoanPM.text = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  staffStaffLoan
                                                      .text.isNotEmpty &&
                                                  staffbasicSalary
                                                      .text.isNotEmpty) {
                                                double dstaffLoanPayPerMonth =
                                                    double.parse(value);
                                                Psalary -=
                                                    dstaffLoanPayPerMonth;
                                                loanPaid = dstaffLoanPayPerMonth
                                                    .toString();

                                                double dstaffLoan =
                                                    double.parse(
                                                        staffStaffLoan.text);

                                                loanBalance = dstaffLoan -
                                                    dstaffLoanPayPerMonth;
                                                // double loanbal = dstaffLoan -
                                                //       dstaffLoanPayPerMonth;
                                                remainingLoan =
                                                    loanBalance.toString();
                                              }
                                              // else if (value.isNotEmpty &&
                                              //     staffStaffLoan.text.isEmpty) {
                                              //   return ("Staff Loan required");
                                              // }
                                              else if (value.isEmpty &&
                                                  staffStaffLoan
                                                      .text.isNotEmpty) {
                                                return ("Staff Loan Pay Per Month required");
                                              } else {
                                                value = "";
                                                staffLoanPayPerMonth1 = "";
                                                remainingLoan = "";
                                                loanPaid = "";
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
                                            controller: staffAcctName,
                                            onSaved: (value) {
                                              staffAcctName.text =
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
                                            controller: staffAcctNumber,
                                            onSaved: (value) {
                                              staffAcctNumber.text = value!;
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
                                            controller: staffBank,
                                            onSaved: (value) {
                                              staffBank.text =
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
                                            controller: staffComment,
                                            onSaved: (value) {
                                              staffComment.text = value!;
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
