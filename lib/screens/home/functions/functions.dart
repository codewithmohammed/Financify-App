  import 'package:intl/intl.dart';

increaseheight(int length, double initialHeight) {
    if (length % 2 != 0) {
      final iterate = (length + 1) / 2;
      for (int i = 1; i < iterate; i++) {
        initialHeight = initialHeight + 50;
      }
      return initialHeight;
    } else {
      final iterate = length / 2;
      for (int i = 1; i < iterate; i++) {
        initialHeight = initialHeight + 50;
      }
      return initialHeight;
    }
  }

   String? selectDate(String whichDate) {
    String formattedDate;
    DateTime today = DateTime.now();
    switch (whichDate) {
      case 'All Time':
        return null;
      case 'Today':
        formattedDate = DateFormat('dd/MMM/yyyy').format(today);
        return formattedDate;
      case 'Yesterday':
        DateTime yesterday = today.subtract(const Duration(days: 1));
        formattedDate = DateFormat('dd/MMM/yyyy').format(yesterday);
        return formattedDate;
      case 'This Month':
        formattedDate = DateFormat('MMM/yyyy').format(today);
        return formattedDate;
      case 'Last Month':
        DateTime lastMonth = today.subtract(const Duration(days: 30));
        formattedDate = DateFormat('MMM/yyyy').format(lastMonth);
        return formattedDate;
      case 'This Year':
        formattedDate = DateFormat('yyyy').format(today);
        return formattedDate;
      case 'Last Year':
        DateTime lastYear = today.subtract(const Duration(days: 365));
        formattedDate = DateFormat('yyyy').format(lastYear);
        return formattedDate;
      default:
        return null;
    }
  }