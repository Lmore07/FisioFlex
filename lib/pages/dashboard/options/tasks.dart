import 'package:fisioflex/pages/designs/appBar.dart';
import 'package:flutter/material.dart';

bool? selected;

class tasksList extends StatefulWidget {
  const tasksList({super.key});

  @override
  State<tasksList> createState() => _tasksListState();
}

class _tasksListState extends State<tasksList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 211, 221, 1),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBarCustom(
              tittle: 'Tareas',
              subTittle: 'Atrás',
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
              child: DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    selected = value;
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
              ),
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
