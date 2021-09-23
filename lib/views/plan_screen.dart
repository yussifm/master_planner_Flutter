// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:master_planner/models/data_layer.dart';
import 'package:master_planner/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({Key? key, required this.plan}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusScopeNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master Planner"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildList()),
          SafeArea(child: Text(plan.completenessMessage)),
        ],
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        controller: scrollController,
        itemCount: plan.task.length,
        itemBuilder: (context, index) {
          return _buildListTitle(plan.task[index]);
        });
  }

  ListTile _buildListTitle(Task task) {
    return ListTile(
      leading: Checkbox(
        value: task.isComplete,
        onChanged: (selected) {
          setState(() {
            task.isComplete = selected!;
          });
        },
      ),
      title: TextFormField(
          initialValue: task.description,
          onFieldSubmitted: (text) {
            setState(() {
              task.description = text;
            });
          }),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          plan.task.add(Task());
        });
      },
      child: Icon(Icons.add),
    );
  }
}
