abstract class Equipment {
  int id;
  String name;
  List<BorrowRecord> borrowRecords;

  bool getAvailable(DateTime startTime,DateTime endTime) {
  }
}

class BorrowRecord {
  int id;
  DateTime startTime,endTime;
  String bookedPerson;
  int leisureId;
  
  BorrowRecord(this.startTime,this.endTime);
}