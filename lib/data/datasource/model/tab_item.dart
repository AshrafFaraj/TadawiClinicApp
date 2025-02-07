import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TabItem {
  TabItem({
    this.stateMachine = "",
    this.artboard = "",
    this.status,
  });

  UniqueKey? id = UniqueKey();
  String stateMachine;
  String artboard;
  late SMIBool? status;

  static List<TabItem> tabItemsList = [
    TabItem(stateMachine: "HOME_interactivity", artboard: "HOME"),
    TabItem(stateMachine: "TIMER_Interactivity", artboard: "TIMER"),
    TabItem(stateMachine: "CHAT_Interactivity", artboard: "CHAT"),
    TabItem(stateMachine: "USER_Interactivity", artboard: "USER"),
  ];
}
