import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:quotidien/components/buttons/orange_button.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  void _showDatePicker(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedDate ?? now;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                minimumDate: now,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  setState(() {
                    _selectedDate = val;
                    _dueDateController.text = DateFormat(
                      'dd MMMM yyyy',
                      'fr_FR',
                    ).format(_selectedDate!);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      final taskName = _nameController;
      final description = _descriptionController;
      final dueDate = _selectedDate;

      print('Tâche ajoutée :');
      print('Nom: $taskName');
      print('Description: $description');
      print('Date d\'échéance: ${DateFormat('dd/MM/yyyy').format(dueDate!)}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('tache ajoutee avec succes!')),
      );

      _formkey.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();
      _dueDateController.clear();
      setState(() {
        _selectedDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //initializeDateFormatting(locale, filePath)

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text('ADD TASK')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/addtask.png', height: 200, width: 200),
              Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Task name',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey, width: 1)
                           ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Color.fromRGBO(249, 139, 66, 1.0))
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un nom pour la tâche.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Description (optionnel)',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey, width: 1)
                           ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Color.fromRGBO(249, 139, 66, 1.0))
                          )
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _dueDateController,
                        decoration: const InputDecoration(
                          hintText: 'Date d\'échéance',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey, width: 1)
                           ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Color.fromRGBO(249, 139, 66, 1.0))
                          ),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _showDatePicker(context);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner une date d\'échéance.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      OrangeButton(text: 'add task', onTap: _submitForm),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
