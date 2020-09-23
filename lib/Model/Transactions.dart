class Transaction{

  final String transID;
  final String transDesc;
  final String transStatus;
  final String  transDateTime;

  Transaction({this.transID,this.transDesc,this.transStatus,this.transDateTime});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transID: json["TransID"].toString(),
    transDesc: json["TransDesc"],
    transStatus: json["TransStatus"],
    transDateTime: json["TransDateTime"]
  );

}

class TransactionList{
  final List<Transaction> transactions;

  TransactionList({this.transactions});


  factory TransactionList.fromJson(List<dynamic> parsedJson) {

    List<Transaction> transactions = new List<Transaction>();
    transactions = parsedJson.map((i)=>Transaction.fromJson(i)).toList();

    return new TransactionList(
       transactions:transactions,
    );
  }

}