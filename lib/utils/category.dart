import 'package:flutter/material.dart';

class Category extends ChangeNotifier {
List<String> incomeCategories = [
  'Salary',
  'Freelance Income',
  'Rental Income',
  'Investment Income',
  'Gift Income',
  'Reimbursements',
  'Refunds',
  'Dividend Income',
  'Interest Income',
  'Business Income',
  'Royalty Income',
  'Alimony',
  'Capital Gains',
  'Scholarship',
  'Lottery Winnings',
];

   List<String> filtertype = [
    'Income',
    'Expense',
    'Transfer',
  ];


  List<String> expenseCategories = [
    'Housing',
    'Utilities',
    'Groceries',
    'Transportation',
    'Health Care',
    'Insurance',
    'Education',
    'Entertainment',
    'Dining Out',
    'Shopping',
    'Personal Care',
    'Debt Payments',
    'Charitable Donations',
    'Taxes',
    'Miscellaneous',
  ];
}
