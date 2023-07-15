import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/cardButton.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:TeraFlex/pages/services/assignmentService.dart';
import 'package:TeraFlex/pages/services/taskService.dart';
import 'package:flutter/material.dart';

bool selected = false;
List<Task> listTasks = [];
DateTime now = DateTime.now();

class tasksList extends StatefulWidget {
  const tasksList({super.key});

  @override
  State<tasksList> createState() => _tasksListState();
}

class _tasksListState extends State<tasksList> {
  @override
  void initState() {
    super.initState();
    CustomEasyLoading.instance.showLoading('Cargando tareas...');
    listTasks.clear();
    getTaskService(selected).then((value) {
      CustomEasyLoading.instance.dismiss();
      if (value.isEmpty) {
        CustomEasyLoading.instance.showMessage('No tiene tareas pendientes');
      }
      setState(() {
        listTasks = value;
      });
    }).catchError((e) {
      Navigator.popAndPushNamed(context, 'dashboard');
      CustomEasyLoading.instance.showError(e.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listTasks.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          listTasks.clear();
          Navigator.restorablePushReplacementNamed(context, 'dashboard');
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBarCustom(
                tittle: 'Tareas',
                subTittle: 'Atrás',
                onPressed: () {
                  Navigator.restorablePushReplacementNamed(
                      context, 'dashboard');
                },
                icon: Icons.arrow_back_rounded,
              )),
          body: Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            margin: EdgeInsets.only(top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Filtrar tareas por:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2F2F2F),
                    fontFamily: 'Nunito'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      selected = value!;
                      listTasks.clear();
                      CustomEasyLoading.instance
                          .showLoading('Cargando tareas...');
                      getTaskService(selected).then((value) {
                        CustomEasyLoading.instance.dismiss();
                        if (value.isEmpty) {
                          CustomEasyLoading.instance
                              .showMessage('No tiene tareas completadas');
                        }
                        setState(() {
                          listTasks = value;
                        });
                      }).catchError((e) {
                        CustomEasyLoading.instance.showError(e.toString());
                      });
                    });
                  },
                  value: selected,
                  items: [
                    DropdownMenuItem(child: Text('Pendientes'), value: false),
                    DropdownMenuItem(child: Text('Completadas'), value: true)
                  ],
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.black,
                  ),
                  iconSize: 50,
                  hint: Text(
                    'Selecciona una opción',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  underline: Container(),
                ),
              ),
              spaced(25, 0),
              taskList()
            ]),
          ),
        ),
      ),
    );
  }
}

class taskList extends StatelessWidget {
  const taskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              for (var task in listTasks)
                if (now.day <= task.dueDate.day &&
                    now.month <= task.dueDate.month &&
                    now.year <= task.dueDate.year)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: cardButtonTaskWidget(
                        icon: Icons.format_list_bulleted_rounded,
                        tittle: task.task.title,
                        subtitle: ' ${task.estimatedTime} minutos',
                        onPressed: () {
                          CustomEasyLoading.instance
                              .showLoading("Cargando tarea...");
                          assignmentDetailService(task.id)
                              .then((assignment) async {
                            List<AssignmentFile> assignmentFiles =
                                assignment.files;
                            List<String> videos = assignmentFiles
                                .map((file) => file.url)
                                .toList();
                            List<int> idVideos =
                                assignmentFiles.map((file) => file.id).toList();
                            await saveListString('videoUrls', videos);
                            await saveListString('idVideos', idVideos);
                            Navigator.pushNamed(context, 'detail-task',
                                arguments: {
                                  'idTask': task.task.id,
                                  'title': task.task.title,
                                  'idAssigment': task.id,
                                  'description': task.task.description,
                                  'time': task.estimatedTime
                                });
                          });
                        }),
                  ),
              spaced(25, 0),
            ],
          ),
        ),
      ),
    );
  }
}
