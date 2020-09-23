import 'package:notification_mail/Db/Services.dart';
import 'package:notification_mail/sendMail.dart';
import 'package:workmanager/workmanager.dart';
import 'Model/Transactions.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Dispatcher{

  static const String _USERNAME = 'jagan6797@gmail.com';
  static const String _PASSWORD = 'kdjmgpf9jbbyq3vh697qcwghc';

  static const String _ADMIN_MAIL_ID = 'jagan6797@gmail.com';

  static  Future callbackDispatcher() async {

    try{
      Transaction trans = await Services.getTransactions();

      if(trans != null) {
        final smtpServer = gmail(_USERNAME, _PASSWORD);

        final message = Message()
          ..from = Address(_USERNAME, 'Admin')
          ..recipients.add(_ADMIN_MAIL_ID)
        //..ccRecipients.addAll(['ADMIN2@example.com', 'ADMIN3@example.com'])
        //..bccRecipients.add(Address('bccADMIN@example.com'))
          ..subject = 'Transaction Status !! ${DateTime.now()}'
          ..text = 'This is the plain text.\nThis is line 2 of the text part.'
          ..html = "<h1>Transaction Error </h1>\n<p>Error "
              "TRANSACTION ID :""${trans.transID}"
              "TRANSACTION DESCRIPTION: ${trans.transDesc} "
              "TRANSACTION STATUS:${trans.transStatus}"
              "TRANSACTION DATETIME :${trans.transDateTime} </p>";

        try {
          final sendReport = await send(message, smtpServer);
          print('Message sent: ' + sendReport.toString());
        } on MailerException catch (e) {
          print('Message not sent.');
          for (var p in e.problems) {
            print('Problem: ${p.code}: ${p.msg}');
          }
        }

        var connection = PersistentConnection(smtpServer);

        // Send the message
        await connection.send(message);

        // close the connection
        await connection.close();

      }

    }catch(e){}
  }
}