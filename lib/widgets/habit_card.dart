import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final Function(String) onDelete;

  HabitCard({required this.habit, required this.onDelete});

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  bool _isCompleted = false; // Состояние для отслеживания выполнения привычки

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: _isCompleted ? Colors.green[100] : Colors.red[100], // Цвет карточки в зависимости от выполнения
      child: ListTile(
        title: Text(
          widget.habit.title,
          style: TextStyle(
            color: _isCompleted ? Colors.green[800] : Colors.red[800], // Цвет текста в зависимости от выполнения
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.habit.description),
            SizedBox(height: 4),
            Text("Период: ${widget.habit.period}"),
            if (widget.habit.selectedDate != null)
              Text(
                "Дата выполнения: ${widget.habit.selectedDate!.toLocal().toString().split(' ')[0]}",
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                setState(() {
                  _isCompleted = true; // Устанавливаем состояние выполнения
                  widget.habit.markCompleted(DateTime.now());
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Привычка выполнена!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.onDelete(widget.habit.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}