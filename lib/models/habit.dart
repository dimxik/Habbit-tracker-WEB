class Habit {
  final String id;
  final String title;
  final String description;
  final String period;
  final DateTime startDate;
  final DateTime? selectedDate; // Новая дата выполнения
  final List<DateTime> completedDates;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.period,
    required this.startDate,
    this.selectedDate,
    this.completedDates = const [],
  });

  void markCompleted(DateTime date) {
    if (!completedDates.contains(date)) {
      completedDates.add(date);
    }
  }
}