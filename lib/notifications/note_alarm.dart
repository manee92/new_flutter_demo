import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

import 'notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  await NotificationService().requestIOSPermissions(); //
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Note Alarm Demo",
      home: MyNoteScreen(),
    );
  }
}

class MyNoteScreen extends StatefulWidget {
  const MyNoteScreen({Key? key}) : super(key: key);

  @override
  _MyNoteScreenState createState() => _MyNoteScreenState();
}

class _MyNoteScreenState extends State<MyNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                    child: NoteThumbnail(
                  color: Color(0xFFFF9C99),
                  title: "Note one",
                  content: "Lorem ipsum",
                  id: 1,
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: NoteThumbnail(
                        id: 2,
                        color: Color(0xFF6fefb0),
                        title: "Note two",
                        content: "Lorem ipsum")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NoteThumbnail extends StatefulWidget {
  final int id;
  final Color color;
  final String title;
  final String content;

  const NoteThumbnail(
      {Key? key,
      required this.id,
      required this.color,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  _NoteThumbnailState createState() => _NoteThumbnailState();
}

class _NoteThumbnailState extends State<NoteThumbnail> {
  DateTime selectedDate = DateTime.now();
  DateTime fullDate = DateTime.now();
  final NotificationService _notificationService = NotificationService();

  Future<DateTime> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
        });
        await _notificationService.scheduleNotifications(
            id: widget.id,
            title: widget.title,
            body: widget.content,
            time: fullDate);
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(widget.content),
          const SizedBox(
            height: 80,
          ),
          Text(fullDate.toString()),
          ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text("Add reminder"))
        ],
      ),
    );
  }
}
