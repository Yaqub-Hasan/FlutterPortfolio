import 'package:die_praxis_manegement/Presentation/Screens/AddOrEditPatient.dart';
import 'package:die_praxis_manegement/Presentation/Screens/PatientDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../DataBase/MedicalCare_database.dart';
import '../../DataBase/model/patient.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> patientsNames = [];
  late List<Patient> patients;
  late bool isLoading;

  refreshPatients() async {
    setState(() {
      isLoading = true;
    });

    this.patients = await MedicalDataBase.instance.readAllPatients();

    for (Patient p in patients) {
      patientsNames.add(p.name);
      print(p.name);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshPatients();
    super.initState();
  }

  @override
  void dispose() {
    MedicalDataBase.instance.Close();
    super.dispose();
  }

  ///====================== Build UI =======================================:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(allPatient: patients));
              },
              icon: Icon(
                Icons.search_outlined,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.red,
        title: Text("قائمة المرضى"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : patients.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    "لا يوجد مرضى بعد",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                )
              : buildListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add),
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddOrEditPatient())).then((value) => setState((){}));
            refreshPatients();
          }),
    );
  }

  ListView buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final patient = patients[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PatientDetailPage(
                            id: patient.id!,
                          ))).then((value) => setState((){}));
            },
            child: Container(
              padding: EdgeInsets.all(2.w),
              margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        " الاسم: ${patient.name}    ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        " العمر: ${patient.age}    ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        " العنوان: ${patient.address}    ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        " الهاتف: ${patient.phoneNumber} 963+   ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 1,
          );
        },
        itemCount: patients.length);
  }
}

//!Very Important:
///=====================================Search Method==================================:
class CustomSearchDelegate extends SearchDelegate {
  final List<Patient> allPatient;

  CustomSearchDelegate({required this.allPatient});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map<int, String>> matchQuery = [];
    for (var item in allPatient) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add({item.id!: item.name});
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var name;
          var id;
          for (var val in matchQuery[index].values) {
            name = val;
          }
          ;
          for (var key in matchQuery[index].keys) {
            id = key;
          }
          ;
          return ListTile(
            title: Text(name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PatientDetailPage(
                            id: id,
                          )));
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<int, String>> matchQuery = [];
    for (var item in allPatient) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add({item.id!: item.name});
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var name;
          var id;
          for (var val in matchQuery[index].values) {
            name = val;
          }
          ;
          for (var key in matchQuery[index].keys) {
            id = key;
          }
          ;
          return ListTile(
            title: Text(name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PatientDetailPage(
                            id: id,
                          )));
            },
          );
        });
  }
}
