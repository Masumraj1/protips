import 'package:intl/intl.dart';

class DateConverter {
  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }


  // Method to format the date from a string
  static String formatDate(dynamic dateStr, {String format = 'MMM dd, yyyy'}) {
    try {
      // Ensure the dateStr is converted to a String
      String dateString = dateStr.toString();  // Cast to String
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString);
      // Use the intl package to format the DateTime into the desired string format
      return DateFormat(format).format(dateTime);
    } catch (e) {
      // Handle any parsing errors or invalid date strings
      print('Error formatting date: $e');
      return 'Invalid date';
    }
  }

  static String calender(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString()}";
  }

  /// Existing method to estimate the date string, if applicable
  static String estimateCalender(DateTime date) {
    // Your existing implementation here (if needed)
    return formatDate(date); // Call formatDate if you want the same format
  }

  // Method to estimate or modify dates (example purpose)
  static String estimatedDates(dynamic dateStr) {
    return formatDate(dateStr);
  }




  static DateTime convertStringToDatetime() {
    DateTime now = DateTime.now();
    return now.toUtc();
  }

  ///=============== Calculate Time of Day ===============

  static String getTimePeriod() {
    // Get the current hour of the day
    int currentHour = DateTime.now().hour;

    // Define the boundaries for morning, noon, and evening
    int morningBoundary = 6;
    int noonBoundary = 12;
    int eveningBoundary = 18;

    // Determine the time period based on the current hour
    if (currentHour >= morningBoundary && currentHour < noonBoundary) {
      return "Good Morning";
    } else if (currentHour >= noonBoundary && currentHour < eveningBoundary) {
      return "Good Noon";
    } else {
      return "Good Evening";
    }
  }

  // Method to convert UTC time to Bangladesh Standard Time (BST, UTC+6)
  static String convertToBDTime(String utcDate) {
    // Parse the UTC DateTime string into a DateTime object
    DateTime utcDateTime = DateTime.parse(utcDate);

    // Convert to Bangladesh Standard Time (BST), which is UTC +6
    DateTime bdDateTime = utcDateTime.add(Duration(hours: 6));

    // Format the DateTime in your desired format
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(bdDateTime);
  }

}