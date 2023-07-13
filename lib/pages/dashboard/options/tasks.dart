import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/cardButton.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:TeraFlex/pages/services/taskService.dart';
import 'package:flutter/material.dart';

bool selected = true;
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
    // TODO: implement initState
    super.initState();
    CustomEasyLoading.instance.showLoading('Cargando tareas...');
    listTasks.clear();
    getTaskService().then((value) {
      CustomEasyLoading.instance.dismiss();
      if (value == null) {
        CustomEasyLoading.instance.showMessage('No hay tareas');
      }
      setState(() {
        listTasks = value;
      });
    }).catchError((e) {
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
          Navigator.pushNamed(context, 'dashboard');
          return true;
        },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(156, 211, 221, 1),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBarCustom(
                tittle: 'Tareas',
                subTittle: 'Atrás',
                onPressed: () {
                  Navigator.pushNamed(context, 'dashboard');
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
                      print(selected);
                    });
                  },
                  value: selected,
                  items: [
                    DropdownMenuItem(child: Text('Pendientes'), value: true),
                    DropdownMenuItem(child: Text('Completadas'), value: false)
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
              SizedBox(
                height: 20,
              ),
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
                  cardButtonTaskWidget(
                      icon: Icons.format_list_bulleted_rounded,
                      tittle: task.task.title,
                      subtitle: ' ${task.estimatedTime} minutos',
                      onPressed: () {
                        Navigator.pushNamed(context, 'detail-task', arguments: {
                          'idTask': task.task.id,
                          'title': task.task.title,
                          'idAssigment': task.id
                        });
                      }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
