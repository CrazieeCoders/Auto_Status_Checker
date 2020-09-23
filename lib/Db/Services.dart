import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notification_mail/Model/Transactions.dart';

class Services{

   static const String ROOT = "https://flutterdatabasejagan.000webhostapp.com/Transactions.php";
   static const String _CREATE_TABLE_ACTION = "CREATE_TABLE";
   static const String _INSERT_TRANS ="ADD_TRANS";
   static const String _GET_ALL = "GET_ALL";

  static Future<String> createTable() async{

    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;

      final response = await http.post(ROOT, body: map);
      print("Create Table response:${response.body}");

      if (response.statusCode == 200) {
        return "success";
      } else {
        return "error";
      }
    }catch(e){
     return "error";
    }
    

  }


  static Future<String> addTransaction(int transID,String transDesc,String transStatus,String transDateTime)async{


    try {
      var map = Map<String, dynamic>();

      map['action'] = _INSERT_TRANS;
      map['TransID'] = transID;
      map['TransDesc'] = transDesc;
      map['TransStatus'] = transStatus;
      map['TransDateTime'] = transDateTime;


      final response = await http.post(ROOT, body: map);

      if(response.statusCode == 200){
        return "success";
      }else{
        return "error";
      }


    }catch(e){
      return "error";
    }

  }

  static Future<Transaction> getTransactions() async{

    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_ALL;
      final response = await http.post(ROOT,body: map);


       if(response.statusCode == 200){

         String result = response.body;

       List<Transaction> list = parseResponse(response.body.substring(22,result.length));

       for(Transaction transaction in list){

         // Check whether DB has any Error Transactions
         if(transaction.transStatus == "Error"){
           return transaction;
         }
       }
         return null;
       }else{
         return null;
       }

    }catch(e){
      return null;
    }


  }

  static List<Transaction> parseResponse(String responseBody){

    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Transaction>((json) => Transaction.fromJson(json)).toList();
  }

}