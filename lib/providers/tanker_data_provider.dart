import 'package:flutter/foundation.dart';

class TankerDataProvider with ChangeNotifier {
  String? location;
  String? date;
  // Add other fields as needed

  void saveData({
    String? location,
    String? date,
    // Other parameters
  }) {
    this.location = location;
    this.date = date;
    // Save other fields
    notifyListeners();
  }

  void clearData() {
    location = null;
    date = null;
    // Clear other fields
    notifyListeners();
  }
} 