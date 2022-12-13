class Item {
  String? title;
  String? date;
  int? progress;

  Item({required this.title, required this.date, required this.progress});
}

var listItem = [
  Item(
      title: "Week 1 Flutter Task",
      date: "Friday 5 November 2022",
      progress: 15),
  Item(
      title: "Week 2 Flutter Task",
      date: "Friday 5 Desember 2022",
      progress: 40),
  Item(
      title: "Week 3 Flutter Task",
      date: "Friday 9 Desember 2022",
      progress: 70)
];
