import 'package:firebase_database/firebase_database.dart';

abstract class Equipment {
  late String name;
  late List<BorrowRecord> borrowRecords;

  bool getAvailable(DateTime startTime,DateTime endTime) {
    return false;
  }
}

class BorrowRecord {
  
  late DateTime startTime,endTime;
  late String bookedPerson;
  
  BorrowRecord(this.startTime,this.endTime);
}