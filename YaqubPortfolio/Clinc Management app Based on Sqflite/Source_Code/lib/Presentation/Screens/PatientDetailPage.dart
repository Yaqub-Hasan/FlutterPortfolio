import 'dart:convert';
import 'dart:typed_data';

import 'package:die_praxis_manegement/Presentation/Screens/HomeScreen.dart';
import 'package:die_praxis_manegement/Presentation/Widgets/DividerWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../DataBase/MedicalCare_database.dart';
import 'AddOrEditPatient.dart';
import '../../DataBase/model/patient.dart';

class PatientDetailPage extends StatefulWidget {
  final int id;
  PatientDetailPage({required this.id});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {


  late Patient patient;
  late bool isLoading;

  refreshPatients() async {
    setState(() {
      isLoading = true;
    });

    this.patient = await MedicalDataBase.instance.readPatient(widget.id);

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              tooltip: 'edit',
              color: Colors.white,
              onPressed: () async {
                if (isLoading) return;
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddOrEditPatient(patient: patient)));
                refreshPatients();
              },
              icon: Icon(Icons.edit)),
          IconButton(
              tooltip: 'delete',
              color: Colors.white,
              onPressed: () async {
                await MedicalDataBase.instance.delete(widget.id);
                Navigator.pop(context);
                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
               // Navigator.pushReplacement(context , MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8),
          children: [
            Container(
              width: patient.profile== '' ?  100 : null,
              height: patient.profile== '' ?  100 : null,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red , width: 2)
              ),
              child: patient.profile != '' ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(imageDecoder() , width: 45.w, height: 45.w  , fit: BoxFit.fill,))  : Icon(Icons.person_outline , color: Colors.red,size: 40.sp,),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                  "${patient.name}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "+963${patient.phoneNumber}",
                    style: TextStyle(color: Colors.black , fontSize: 16.sp),
                  ),
                IconButton(
                  icon: Icon(Icons.phone , color: Colors.green,), onPressed: () async {
                    var zero = "+963";
                    var tel = 'tel: $zero${patient.phoneNumber}';
                    if(await canLaunchUrl(Uri.parse(tel))){
                      await launchUrl(Uri.parse(tel));
                    }
                },
                ),
                IconButton(
                  icon: Icon(Icons.message , color: Colors.yellow,), onPressed: ()async {
                  var zero = "+963";
                  var tel = 'sms: $zero${patient.phoneNumber}';
                  if(await canLaunchUrl(Uri.parse(tel))){
                  await launchUrl(Uri.parse(tel));
                  }
                },
                ),
              ],
            ),
            DividerWidget(),
            SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                " تاريخ القدوم : ${intl.DateFormat.yMMMd().format(patient.createdTime)}",
                style: TextStyle(color: Colors.blue , fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                " العنوان: ${patient.address}",
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                " العمر: ${patient.age}",
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                " الوزن: ${patient.weight}",
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ),
            DividerWidget(),
            SizedBox(height: 8),
            YesOrNoSituationsWidget(situation: patient.stomachache , SituationName: "ألم معدة"),
            YesOrNoSituationsWidget(situation: patient.fever , SituationName: "حرارة"),
            YesOrNoSituationsWidget(situation: patient.diarrhea , SituationName: "اسهال"),
            YesOrNoSituationsWidget(situation: patient.vomiting , SituationName: "اقياء"),
            YesOrNoSituationsWidget(situation: patient.jointPain , SituationName: "ألم مفاصل"),
            YesOrNoSituationsWidget(situation: patient.cough , SituationName: "سعال"),
          ],
        ),
      ),
    );
  }

  YesOrNoSituationsWidget({bool? situation , String? SituationName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(SituationName! , style: TextStyle(fontSize: 15.sp),),
        SizedBox(width: 3.w,),
        situation == false ? Icon(Icons.cancel , color: Colors.red,) : Icon(Icons.done , color: Colors.green,),

      ],
    );
  }

  imageDecoder() {
    return Base64Decoder().convert(patient.profile);
  }
}
