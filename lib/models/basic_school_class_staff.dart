import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phrankstar/models/http_exception.dart';

import 'basic_school_class.dart';

class PCAS with ChangeNotifier {
  String? id;
  String? authToken;
  String? _userId;

  List<PCA> _staffs = [];

  List<PCA> get staff {
    _staffs.sort((a, b) => a.staff_name1!.compareTo(b.staff_name1!));
    return [..._staffs];
  }

  void search(String pca) {
    List<PCA> staffName = List.from(_staffs);
    // staffName = _staffs.where((e) => e.staff_name1!.toLowerCase().contains(pca.toLowerCase()));
  }

  void update(String? token, String? userId) {
    authToken = token;
    _userId = userId;
  }

  Future<void> addNewStaff(PCA pca) async {
    //
    final url = ''; //connect to firebase database to add staff

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'staff_name1': pca.staff_name1,
            'staff_position1': pca.staff_position1,
            'staff_phoneNumber1': pca.staff_phoneNumber1,
            'staffSalary1': pca.staffSalary1,
            'staffBonus1': pca.staffBonus1,
            'staffDeduction1': pca.staffDeduction1,
            'staffSavings1': pca.staffSavings1,
            'staffSavingsPerMonth1': pca.staffSavingsPerMonth1,
            'staffLoan1': pca.staffLoan1,
            'staffLoanPayPerMonth1': pca.staffLoanPayPerMonth1,
            'staff_bankAccountName1': pca.staff_bankAccountName1,
            'staff_accountNumber1': pca.staff_accountNumber1,
            'staff_bankName1': pca.staff_bankName1,
            'staff_commentary1': pca.staff_commentary1,
            'createdDate': pca.createdDate,
            'staff_salary_increment1': pca.staff_salary_increment1,
            'id': '',
            'payable': pca.payable,
            'trackingDate': pca.trackingDate,
            'remainingLoan': pca.remainingLoan,
            'loanPaid': pca.loanPaid,
            'staffResignationAllowance1': pca.staffResignationAllowance1,
            'staffYearAllowanceBalance': pca.staffYearAllowanceBalance,
            'staffEndOfYearAllowanceTxtV': pca.staffEndOfYearAllowanceTxtV

            // pca.toMap()
          }));
      id = json.decode(response.body)['name'];
      final url2 = ''; //connect to firebase database to fetch staff id
      await http.patch(Uri.parse(url2), body: json.encode({'id': id}));

      final newStaff = PCA(
          staff_name1: pca.staff_name1,
          staff_position1: pca.staff_position1,
          staff_phoneNumber1: pca.staff_phoneNumber1,
          staffSalary1: pca.staffSalary1,
          staffBonus1: pca.staffBonus1,
          staffDeduction1: pca.staffDeduction1,
          staffSavings1: pca.staffSavings1,
          staffSavingsPerMonth1: pca.staffSavingsPerMonth1,
          staffLoan1: pca.staffLoan1,
          staffLoanPayPerMonth1: pca.staffLoanPayPerMonth1,
          staff_bankAccountName1: pca.staff_bankAccountName1,
          staff_accountNumber1: pca.staff_accountNumber1,
          staff_bankName1: pca.staff_bankName1,
          staff_commentary1: pca.staff_commentary1,
          createdDate: pca.createdDate,
          staff_salary_increment1: pca.staff_salary_increment1,
          payable: pca.payable,
          id: json.decode(response.body)['name'],
          trackingDate: pca.trackingDate,
          remainingLoan: pca.remainingLoan,
          loanPaid: pca.loanPaid,
          staffResignationAllowance1: pca.staffResignationAllowance1,
          staffYearAllowanceBalance: pca.staffYearAllowanceBalance,
          staffEndOfYearAllowanceTxtV: pca.staffEndOfYearAllowanceTxtV);

      _staffs.add(newStaff);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  PCA findById(String id) {
    return _staffs.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(String id, PCA pca) async {
    final productIndex = _staffs.indexWhere((prod) => prod.id == id);

    if (productIndex >= 0) {
      try {
        final url = ''; // connect to firebase database to update staff
        await http.patch(Uri.parse(url),
            body: json.encode({
              'staff_name1': pca.staff_name1,
              'staff_position1': pca.staff_position1,
              'staff_phoneNumber1': pca.staff_phoneNumber1,
              'staffSalary1': pca.staffSalary1,
              'staffBonus1': pca.staffBonus1,
              'staffDeduction1': pca.staffDeduction1,
              'staffSavings1': pca.staffSavings1,
              'staffSavingsPerMonth1': pca.staffSavingsPerMonth1,
              'staffLoan1': pca.staffLoan1,
              'staffLoanPayPerMonth1': pca.staffLoanPayPerMonth1,
              'staff_bankAccountName1': pca.staff_bankAccountName1,
              'staff_accountNumber1': pca.staff_accountNumber1,
              'staff_bankName1': pca.staff_bankName1,
              'staff_commentary1': pca.staff_commentary1,
              'createdDate': pca.createdDate,
              'staff_salary_increment1': pca.staff_salary_increment1,
              'id': pca.id,
              'payable': pca.payable,
              'trackingDate': pca.trackingDate,
              'remainingLoan': pca.remainingLoan,
              'loanPaid': pca.loanPaid,
              'staffResignationAllowance1': pca.staffResignationAllowance1,
              'staffYearAllowanceBalance': pca.staffYearAllowanceBalance,
              'staffEndOfYearAllowanceTxtV': pca.staffEndOfYearAllowanceTxtV
            }));
        _staffs[productIndex] = pca;
        notifyListeners();
      } catch (e) {
        throw HttpException(e.toString());
      }
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final url = ''; //connect to firebase database to delete staff

      final existingProductIndex = _staffs.indexWhere((prod) => prod.id == id);
      var existingProduct = _staffs[existingProductIndex];

      _staffs.removeAt(existingProductIndex);
      notifyListeners();

      final response = await http.delete(Uri.parse(url));
      if (response.statusCode >= 400) {
        _staffs.insert(existingProductIndex, existingProduct);
        notifyListeners();
        HttpException('Could not delete staff.\n Try again later.');
      }
      // ignore: null_check_always_fails
      existingProduct = null!;
    } catch (e) {
      throw HttpException(e.toString());
    }

    // _items.removeWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetBasicStaff() async {
    // fetch data by id
    // var url =
    //     'https://flutter-update-23b95-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$_userId"';

    // final filterString =
    //     filterByUser ? 'orderBy="creatorId"&equalTo="$_userId"' : '';
    // ?auth=$authToken
    var url = ''; //connect to fetch staff details

    try {
      final response = await http.get(Uri.parse(url));

      final List<PCA> loadedProducts = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      extractedData.forEach((prodId, staffDetails) {
        if (extractedData.isEmpty) {
          return;
        }
        loadedProducts.add(PCA(
          staff_name1: staffDetails['staff_name1'],
          staff_position1: staffDetails['staff_position1'],
          staff_phoneNumber1: staffDetails['staff_phoneNumber1'],
          staffSalary1: staffDetails['staffSalary1'],
          staffBonus1: staffDetails['staffBonus1'],
          staffDeduction1: staffDetails['staffDeduction1'],
          staffSavings1: staffDetails['staffSavings1'],
          staffSavingsPerMonth1: staffDetails['staffSavingsPerMonth1'],
          staffLoan1: staffDetails['staffLoan1'],
          staffLoanPayPerMonth1: staffDetails['staffLoanPayPerMonth1'],
          staff_bankAccountName1: staffDetails['staff_bankAccountName1'],
          staff_accountNumber1: staffDetails['staff_accountNumber1'],
          staff_bankName1: staffDetails['staff_bankName1'],
          staff_commentary1: staffDetails['staff_commentary1'],
          createdDate: staffDetails['createdDate'],
          staff_salary_increment1: staffDetails['staff_salary_increment1'],
          id: prodId,
          payable: staffDetails['payable'],
          trackingDate: staffDetails['trackingDate'],
          remainingLoan: staffDetails['remainingLoan'],
          loanPaid: staffDetails['loanPaid'],
          staffResignationAllowance1:
              staffDetails['staffResignationAllowance1'],
          staffYearAllowanceBalance: staffDetails['staffYearAllowanceBalance'],
          staffEndOfYearAllowanceTxtV:
              staffDetails['staffEndOfYearAllowanceTxtV'],
        ));
      });

      _staffs = loadedProducts;
      notifyListeners();
    } catch (error) {
      // print(error);
      throw HttpException(error.toString());
    }
  }
}
