import 'package:financify/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: appTheme.darkblue,
        title: Text(
          'About Financify',
          style: TextStyle(color: appTheme.primaryColor),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Welcome to Financify \n- Your Ultimate Offline Money Management App!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: appTheme.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Take control of your finances with Financify, the app designed to empower you in managing your money seamlessly, even without an internet connection. With Financify, you can effortlessly handle multiple bank accounts and perform various operations such as tracking income, recording expenses, and transferring funds between your accounts - all offline!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: appTheme.mainTextColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Key Features:',
                style: TextStyle(color: appTheme.primaryColor, fontSize: 20),
              ),
              const Titleandcaption(
                title: 'Offline Accessibility:',
                caption:
                    '''Enjoy the flexibility of managing your finances anytime, anywhere, without the need for an internet connection. Your financial data is securely stored on your device, ensuring your privacy.''',
              ),
              const Titleandcaption(
                title: 'Multi-Account Management:',
                caption:
                    '''Financify allows you to add and manage multiple bank accounts, making it convenient for you to keep track of your various financial streams in one place.''',
              ),
              const Titleandcaption(
                title: 'Income Tracking:',
                caption:
                    '''Easily log your income transactions to maintain a clear overview of your cash flow. Categorize your income sources for better organization.''',
              ),
              const Titleandcaption(
                title: 'Expense Recording:',
                caption:
                    '''Keep a detailed record of your expenses with Financify. Categorize your expenditures to identify spending patterns and make informed financial decisions.''',
              ),
              const Titleandcaption(
                title: 'Transfer Funds:',
                caption:
                    '''Seamlessly transfer funds between your added accounts. Financify makes it simple to manage your money within the app, ensuring you have full control over your financial transactions.''',
              ),
              const Titleandcaption(
                title: 'Transaction History:',
                caption:
                    '''Access a comprehensive transaction history for each account, allowing you to review past activities and plan for the future.''',
              ),
              const Titleandcaption(
                title: 'Customizable Categories:',
                caption:
                    '''Tailor your expense and income categories to suit your unique financial habits. Financify adapts to your needs, providing a personalized money management experience.''',
              ),
              const Titleandcaption(
                title: 'Reports and Insights:',
                caption:
                    '''Gain valuable insights into your spending habits and financial trends with easy-to-read reports. Make informed decisions based on a clear understanding of your financial behavior.''',
              ),
              const Titleandcaption(
                title: 'Security and Privacy:',
                caption:
                    '''Your financial data is your business. Financify prioritizes the security of your information, ensuring that your offline financial management experience is both reliable and private.''',
              ),
              SizedBox(
                  width: 150,
                  child: Image.asset(
                    'assets/images/financify.png',
                  )),
            ],
          ),
        ),
      )),
    );
  }
}

class Titleandcaption extends StatelessWidget {
  final String? title;
  final String? caption;
  const Titleandcaption(
      {super.key, required this.title, required this.caption});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          title!,
          style: const TextStyle(
              color: Color.fromARGB(255, 131, 131, 131), fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          caption!,
          textAlign: TextAlign.center,
          style: TextStyle(color: appTheme.mainTextColor, fontSize: 15),
        ),
      ],
    );
  }
}
