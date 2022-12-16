class StatusTask {
  String? name;
  String? image;

  StatusTask({required this.name, this.image});
}

List<StatusTask> StatusList = [
  StatusTask(name: "To-do"),
  StatusTask(
    name: "Doing",
  ),
  StatusTask(name: "Completed", image: "assets/images/icons/check.svg")
];
