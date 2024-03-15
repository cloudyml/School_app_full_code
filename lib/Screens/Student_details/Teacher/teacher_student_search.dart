import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class TeacherSearchStudent extends StatefulWidget {
   TeacherSearchStudent({super.key});

  @override
  State<TeacherSearchStudent> createState() => _TeacherSearchStudentState();
}

class _TeacherSearchStudentState extends State<TeacherSearchStudent> {
  final _searchController = TextEditingController();

  List<String> students = List.generate(15, (index) => "Student Name $index");

  List<String> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents.addAll(students);
  }

  void _filterStudents(String query) {
    setState(() {
      filteredStudents = students.where((student) => student.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.3,
        ),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: Column(
            children: [
              appbar("assets/flaticon/student.png", "Student Details", context, () {
                Navigator.pop(context);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterStudents,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white,),
                      hintStyle: TextStyle(color: Colors.white, decorationThickness: 0.0),
                      hintText: "Search student details by name",
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),)
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: filteredStudents.isNotEmpty ? List.generate(filteredStudents.length, (index) {
            return ListTile(
              tileColor: Colors.white,
              onTap: (){},
              splashColor: lightBlue,
              title: Text(filteredStudents[index]),
              subtitle: Text("Class $index"),
              leading: CircleAvatar(maxRadius: 22, child: Icon(Icons.person, color: Colors.grey,),),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total: ${index+10}"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Present: ",),
                      Text("${index+4}", style: TextStyle(color: Colors.green),),
                    ],
                  ),
                ],
              ),
            );
          }) : [Center(child: Text("No data found."))],
        ),
      ),
    );
  }
}
