import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/habit.dart';

class AddHabitScreen extends StatefulWidget {
  final Function(Habit) onHabitAdded;

  AddHabitScreen({required this.onHabitAdded});

  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedPeriod = 'Ежедневно';
  DateTime? _selectedDate;

  final List<String> _periods = [
    'Ежедневно',
    'Еженедельно',
    'Ежемесячно',
  ];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newHabit = Habit(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        period: _selectedPeriod,
        startDate: DateTime.now(),
        selectedDate: _selectedDate,
      );

      // Возвращаем новую привычку через Navigator.pop
      Navigator.pop(context, newHabit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавить привычку"),
        backgroundColor: Colors.deepPurple, // Цвет фона AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Цвет фона экрана
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Название привычки",
                  labelStyle: TextStyle(color: Colors.deepPurple), // Цвет текста метки
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Цвет подчеркивания
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Введите название привычки";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Описание привычки",
                  labelStyle: TextStyle(color: Colors.deepPurple), // Цвет текста метки
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Цвет подчеркивания
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Введите описание привычки";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedPeriod,
                items: _periods.map((period) {
                  return DropdownMenuItem(
                    value: period,
                    child: Text(period, style: TextStyle(color: Colors.deepPurple)), // Цвет текста
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPeriod = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Период выполнения",
                  labelStyle: TextStyle(color: Colors.deepPurple), // Цвет текста метки
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Цвет подчеркивания
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Выберите дату выполнения:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple), // Цвет текста
              ),
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 365)),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.orange, // Цвет выделенной даты
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.green, // Цвет сегодняшней даты
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Цвет кнопки
                ),
                child: Text("Добавить привычку", style: TextStyle(color: Colors.white)), // Цвет текста кнопки
              ),
            ],
          ),
        ),
      ),
    );
  }
}