import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotidien/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final Function(bool?)? onStatusChanged;

  const TaskTile({super.key, 
  required this.onStatusChanged, 
  required this.onTap,
  required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Checkbox(
              value: task.isCompleted, 
              onChanged: onStatusChanged,
              activeColor: Color.fromRGBO(249, 139, 66, 1.0),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted
                      ?TextDecoration.lineThrough
                      : TextDecoration.none,
                      color: task.isCompleted? Colors.grey : Colors.black,
                    ),
                  ),
                  if (task.description.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        decoration: task.isCompleted
                        ?TextDecoration.lineThrough
                        : TextDecoration.none
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                      color: task.dueDate.isBefore(DateTime.now())
                      && !task.isCompleted?Colors.red:Colors.grey,
                      size: 16,),
                      SizedBox(width: 4,),
                      Text(
                        DateFormat('dd MMMM yyyy', 'fr_FR').format(task.dueDate),
                        style: TextStyle(
                          color: task.dueDate.isBefore(DateTime.now())&&
                          !task.isCompleted?Colors.red: Colors.grey,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
        ),
      ),
    );
  }
}
