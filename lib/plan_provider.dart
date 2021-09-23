// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import './models/data_layer.dart';

class PlanProvider extends InheritedWidget {
  final _plan = <Plan>[];
  PlanProvider({Key? key, Widget? child}) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static List<Plan> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._plan;
  }
}
