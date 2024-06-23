import 'package:crud_app_sqlite/src/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool isStatus = false;
  final textContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black87,
        title: Text(
          'Criar Tarefa',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: textContent,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: 'Digite a tarefa...'),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black87),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(25, 15, 25, 15))),
                onPressed: () async {
                  final tarefa =
                      TaskModel(content: textContent.text, status: 0);
                  Navigator.of(context).pop(
                    tarefa,
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Criar tarefa",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.add)
                  ],
                ))
          ],
        ),
      ),
    );
  }

  convertBool() {
    if (isStatus == false) return 0;
    return 1;
  }
}
