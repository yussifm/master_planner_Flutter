import 'package:flutter/material.dart';
import 'package:master_planner/plan_provider.dart';
import 'package:master_planner/views/plan_creator_screen.dart';
import 'package:master_planner/views/plan_screen.dart';

void main() {
  runApp(const MasterPlanApp());
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const PlanCreatorScreen(),
    ));
  }
}
