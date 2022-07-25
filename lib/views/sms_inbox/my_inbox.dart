import 'package:flutter/material.dart';
import 'package:sms_email_retreiver/views/sms_inbox/sms_bloc.dart';

class MyInbox extends StatefulWidget {
  const MyInbox({Key? key}) : super(key: key);

  @override
  State createState() {
    return MyInboxState();
  }
}

class MyInboxState extends State {
  late SMSBloc smsBloc;

  @override
  void initState() {
    smsBloc = SMSBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SMS Inbox"),
          backgroundColor: Colors.red,
        ),
        body: FutureBuilder(
          future: smsBloc.fetchSMS(),
          builder: (context, snapshot) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                    ),
                itemCount: smsBloc.messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.markunread,
                        color: Colors.pink,
                      ),
                      title: Text(smsBloc.messages[index].sender),
                      subtitle: Text(
                        smsBloc.messages[index].body,
                        maxLines: 2,
                        style: const TextStyle(),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
