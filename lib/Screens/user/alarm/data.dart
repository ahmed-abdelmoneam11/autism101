
import 'package:autism101/model/alarm_info.dart';
import 'package:autism101/model/menu_info.dart';

import 'enums.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Its time',
      gradientColorIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Its time',
      gradientColorIndex: 1),
];
