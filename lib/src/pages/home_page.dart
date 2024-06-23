import 'package:crud_app_sqlite/src/controllers/home_controller.dart';
import 'package:crud_app_sqlite/src/models/task_model.dart';
import 'package:crud_app_sqlite/src/pages/task_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final ValueNotifier<String> textContent = ValueNotifier('');

  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Tarefa excluída.'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addTaskButton(),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Minhas Tarefas',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ValueListenableBuilder<List<TaskModel>>(
          valueListenable: controller.listValue,
          builder: (_, list, __) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (cntx, inx) {
                final item = list[inx];
                bool isStatus = item.status == 1;

                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.content,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        textContent.value = value;
                                      },
                                      initialValue: item.content,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        hintText: 'Digite a tarefa...',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    FilledButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.black87,
                                        ),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final tarefa = TaskModel(
                                          content: textContent.value,
                                          status: item.status,
                                          id: item.id,
                                        );
                                        controller.updateTasks(tarefa);
                                        Navigator.of(context).pop(tarefa);
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Editar tarefa",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.edit),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        controller.deleteTask(item.id!);
                        showSnackBar(context);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red[300],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                      value: isStatus,
                      onChanged: (value) {
                        setState(() {
                          isStatus = value!;
                        });

                        final tarefa = TaskModel(
                          content: item.content,
                          status: value! ? 1 : 0,
                          id: item.id,
                        );
                        controller.updateTasks(tarefa);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TaskPage(),
          ),
        );
        if (result != null && result is TaskModel) {
          controller.addTask(result);
        }
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
