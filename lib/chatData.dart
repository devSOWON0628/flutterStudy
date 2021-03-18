import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
class ChatData {
  String userName;
  String message;
  String chatId;

  ChatData.name(this.userName, this.message, this.chatId);

  ChatData({this.userName, this.message});
  ChatData.fromSnapshot(String name, String message, String Id) :
        this.userName = name,
        this.message = message,
        this.chatId = Id;

  toJson(String userName, String message, String chatId) {
    return {
      "userName": userName,
      "message": message,
      "chatId": chatId,
    };
  }
}