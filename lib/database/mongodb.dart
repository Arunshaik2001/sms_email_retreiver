

import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:sms_email_retreiver/utils/contants.dart';

class MongoDB{

  static late Db db;
  static late DbCollection dbCollection;
  static connect() async{
    var db = await Db.create(Constants.MONGO_URL);
    await db.open();
    inspect(db);
    print(await db.serverStatus());
    dbCollection = db.collection(Constants.COLL_NAME);
    print(await dbCollection.find().toList());
  }

  static addDocuments(List<Map<String,dynamic>> documents){
    dbCollection.insertMany(documents);
  }

  static Future<bool> addDocument(Map<String,dynamic> document) async{
    var res = await dbCollection.insertOne(document);
    return res.isSuccess;
  }
}

