import 'task.dart';

class Plan {
  String name = '';
  final List<Task> task = [];

  int get completeCount => task.where((task) => task.isComplete).length;

  String get completenessMessage =>
      '$completeCount out of ${task.length} tasks';
}
