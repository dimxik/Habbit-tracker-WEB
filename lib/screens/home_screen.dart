import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_card.dart';
import 'add_habit_screen.dart'; // Импортируем экран добавления привычки

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Habit> habits = [];

  void _deleteHabit(String id) {
    setState(() {
      habits.removeWhere((habit) => habit.id == id);
    });
  }

  void _addHabit(Habit newHabit) {
    setState(() {
      habits.add(newHabit);
    });
  }

  void _navigateToAddHabitScreen() async {
    // Ожидаем результат из экрана добавления привычки
    final newHabit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddHabitScreen(onHabitAdded: _addHabit),
      ),
    );

    // Если привычка была добавлена, обновляем состояние
    if (newHabit != null) {
      _addHabit(newHabit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Plant"),
        backgroundColor: Colors.deepPurple, // Цвет фона AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Цвет фона экрана
        child: ListView.builder(
          itemCount: habits.length,
          itemBuilder: (ctx, index) {
            return HabitCard(
              habit: habits[index],
              onDelete: _deleteHabit,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddHabitScreen,
        backgroundColor: Colors.blueAccent, // Цвет кнопки
        child: Icon(Icons.add),
      ),
    );
  }
}