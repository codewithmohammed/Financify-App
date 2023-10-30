import 'package:financify/utils/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.darkblue,
        leading: const Icon(
          Icons.menu,
          color: AppTheme.primaryColor,
        ),
        title: const Text(
          'HOME',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              listOfAccounts(),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTheme.darkblue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'List of Accounts',
                        style: TextStyle(
                            color: AppTheme.mainTextColor, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 350,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTheme.darkblue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          'data',
                          style: TextStyle(color: AppTheme.mainTextColor),
                        ),
                        PieChart(
                            swapAnimationDuration:
                                const Duration(milliseconds: 750),
                            PieChartData(
                                sectionsSpace: 0,
                                centerSpaceRadius: 120,
                                sections: [
                                  PieChartSectionData(
                                     titleStyle: const TextStyle(
                                          color: AppTheme.mainTextColor),
                                      value: 30, color: Colors.green),
                                  PieChartSectionData(
                                      titleStyle: const TextStyle(
                                          color: AppTheme.mainTextColor),
                                      value: 500,
                                      color: Colors.red)
                                ])),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container listOfAccounts() {
    return Container(
      width: double.infinity,
      height: 215,
      decoration: BoxDecoration(
        color: AppTheme.darkblue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'List of Accounts',
              style: TextStyle(color: AppTheme.mainTextColor, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 100, // Set the fixed height of the container
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 4),
                    itemCount: 4, // Set the number of items in the GridView
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .amber, // Customize the color of each tile
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Acc Name'), Text('5000')],
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 30,
                child: OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'ADD ACCOUNT',
                      style: TextStyle(color: AppTheme.mainTextColor),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
