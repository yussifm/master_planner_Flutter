// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:master_planner/models/data_layer.dart';
import 'package:master_planner/plan_provider.dart';
import 'package:master_planner/views/plan_screen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({Key? key}) : super(key: key);

  @override
  _PlanCreatorScreenState createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master Plans"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildListCreator(context),
          Expanded(child: _buildMasterPlans()),
        ],
      ),
    );
  }

  Widget _buildListCreator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            label: Text("Add a Plan"),
            contentPadding: EdgeInsets.all(20),
          ),
          onEditingComplete: addPlan(),
        ),
      ),
    );
  }

  addPlan() {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }

    final plan = Plan()..name = text;
    PlanProvider.of(context).add(plan);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildMasterPlans() {
    final plan = PlanProvider.of(context);

    if (plan.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note, size: 100, color: Colors.grey),
          Text(
            'You do not have any plans yet.',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      );
    }

    return ListView.builder(
        itemCount: plan.length,
        itemBuilder: (context, index) {
          final plans = plan[index];
          return ListTile(
            enabled: true,
            title: Text(plans.name),
            subtitle: Text(plans.completenessMessage),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlanScreen(
                        plan: plans,
                      )));
            },
            onLongPress: () {
              plan.remove(plans);
            },
          );
        });
  }
}
