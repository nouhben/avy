import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CustomTimeStamp {
  // type: String
// final jsonData = '{ "name": "Pizza da Mario", "cuisine": "Italian" }';
// type: dynamic (runtime type: _InternalLinkedHashMap<String, dynamic>)
// final parsedJson = jsonDecode(jsonData);
  const CustomTimeStamp({
    required this.emoji,
    required this.timeStamp,
  });
  final String emoji;
  final Timestamp timeStamp;

  factory CustomTimeStamp.fromJson(Map<String, dynamic> data) {
    final _emoji = data['emoji'] as String?;
    final _timeStamp = data['timeStamp'] as Timestamp;
    if (_emoji == null) {
      throw UnsupportedError('Invalid data: $_emoji -> "emoji" is missing');
    }
    return CustomTimeStamp(emoji: _emoji, timeStamp: _timeStamp);
  }
  Map<String, dynamic> toMap() {
    return {'emoji': emoji, 'timeStamp': timeStamp};
  }
}
