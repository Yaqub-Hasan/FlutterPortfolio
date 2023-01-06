import 'dart:convert';
import 'dart:io';

import 'package:die_praxis_manegement/DataBase/MedicalCare_database.dart';
import 'package:die_praxis_manegement/DataBase/model/patient.dart';
import 'package:die_praxis_manegement/Presentation/Widgets/CheckBoxRow.dart';
import 'package:die_praxis_manegement/Presentation/Widgets/NormalTextField.dart';
import 'package:die_praxis_manegement/Presentation/Widgets/SimpleDropDownWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/ButtonWidget.dart';
import '../Widgets/ValidatorTextField.dart';
import 'HomeScreen.dart';

class AddOrEditPatient extends StatefulWidget {
  final Patient? patient;

  const AddOrEditPatient({super.key, this.patient});

  @override
  State<AddOrEditPatient> createState() => _AddOrEditPatientState();
}

class _AddOrEditPatientState extends State<AddOrEditPatient> {
  ///=================== Variables ==============================
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController stomachachePainIntensityController =TextEditingController();
  bool stomachache= false;
  bool vomiting = false;
  bool jointPain = false;
  bool fever = false;
  bool diarrhea = false;
  bool cough = false;
  String intensity = "";
  File? image;
  String profile = "";
  final _formKey = GlobalKey<FormState>();

  ///================== Methods ================================
  void addOrUpdatePatient() async {
    if (_formKey.currentState!.validate()) {
      final isUpdating = widget.patient != null;

      if (isUpdating) {
        await updatePatient();
        Navigator.pop(context);
      } else {
        await addPatient();
        Navigator.pop(context);
      }
    }
    //Navigator.pop(context);
  }

  Future updatePatient() async {
    final patient = widget.patient!.copy(
        //id: widget.patient!.id,
        name: nameController.text,
        address: addressController.text,
        age: int.parse(ageController.text),
        phoneNumber: int.parse(phoneController.text),
        intensity: intensity,
        profile: profile,
        cough: cough,
        diarrhea: diarrhea,
        fever: fever,
        jointPain: jointPain,
        stomachache: stomachache,
        weight: weightController.text,
        stomachachePainIntensity: stomachachePainIntensityController.text,
        vomiting: vomiting);
    await MedicalDataBase.instance.update(patient);
  }

  Future addPatient() async {
    final patient = Patient(
        name: nameController.text,
        address: addressController.text,
        age: int.parse(ageController.text),
        phoneNumber: int.parse(phoneController.text),
        createdTime: DateTime.now() ,
        intensity: intensity,
        cough: cough,
        diarrhea: diarrhea,
        fever: fever,
        jointPain: jointPain,
        stomachache: stomachache,
        weight: weightController.text,
        stomachachePainIntensity: stomachachePainIntensityController.text,
        vomiting: vomiting,
        profile: profile
    );
    await MedicalDataBase.instance.create(patient);
  }

  @override
  void initState() {
    super.initState();
    ageController.text = widget.patient?.age.toString() ?? "";
    phoneController.text = widget.patient?.phoneNumber.toString() ?? '';
    nameController.text = widget.patient?.name ?? '';
    addressController.text = widget.patient?.address ?? '';
    weightController.text = widget.patient?.weight ?? '';
    stomachachePainIntensityController.text = widget.patient?.stomachachePainIntensity ?? '';
    intensity = widget.patient?.intensity ?? '';
    profile = widget.patient?.profile ?? '';
    cough = widget.patient?.cough ?? false;
    vomiting = widget.patient?.vomiting ?? false;
    jointPain = widget.patient?.jointPain ?? false;
    stomachache = widget.patient?.stomachache ?? false;
    diarrhea = widget.patient?.diarrhea ?? false;
    fever = widget.patient?.fever ?? false;
  }

  ///=========Image Picker Method==================:
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final imageTemporary = File(image.path);
      final bytes = File(image.path).readAsBytesSync();
      setState(() {
        this.image = imageTemporary;
        this.profile = base64Encode(bytes);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }


  //?===============Build Method=========================:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "إضافة مريض جديد",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(2.0.w),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 2.0.w,),
              ProfileImageWidget(),
              SizedBox(height: 2.0.w,),
              TextFieldWidget(
                  styleColor: Colors.black,
                  labelText: "اسم المريض",
                  icon: Icons.person,
                  borderColor: Colors.red,
                  hintText: "الاسم",
                  controller: nameController,
                  onChange: () {}),
              TextFieldWidget(
                  styleColor: Colors.black,
                  labelText: "عمر المريض",
                  icon: Icons.info,
                  textInputType: TextInputType.number,
                  borderColor: Colors.red,
                  hintText: "العمر",
                  controller: ageController,
                  onChange: () {}),
              TextFieldWidget(
                  styleColor: Colors.black,
                  labelText: "عنوان المريض",
                  icon: Icons.location_city,
                  borderColor: Colors.red,
                  hintText: "العنوان",
                  controller: addressController,
                  onChange: () {}),
              TextFieldWidget(
                  styleColor: Colors.black,
                  labelText: "رقم الهاتف للمريض",
                  icon: Icons.phone,
                  textInputType: TextInputType.phone,
                  borderColor: Colors.red,
                  hintText: "الهاتف",
                  controller: phoneController,
                  onChange: () {}),
              //!new For DataBase:
              TextFieldWidget(
                  styleColor: Colors.black,
                  labelText: "الوزن",
                  icon: Icons.line_weight,
                  textInputType: TextInputType.number,
                  borderColor: Colors.red,
                  hintText: "الوزن",
                  controller: weightController,
                  onChange: () {}),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    " الأعراض الرئيسية: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  )),
              CheckBoxRow(
                  initialValue: stomachache,
                  textState: "ألم بطني",
                  onChange: (value) {
                    setState(() {
                      stomachache = value;
                    });
                  }),
              stomachache == true ? stomachacheAdditions() : Container(),
              CheckBoxRow(
                  initialValue: vomiting,
                  textState: "إقياء",
                  onChange: (value) {
                    vomiting = value;
                  }),
              CheckBoxRow(
                 initialValue: diarrhea,
                  textState: "إسهال",
                  onChange: (value) {
                    diarrhea = value;
                  }),
              CheckBoxRow(
                  initialValue: fever,
                  textState: "حرارة",
                  onChange: (value) {
                    fever = value;
                  }),
              CheckBoxRow(
                  initialValue: cough,
                  textState: "سعال",
                  onChange: (value) {
                    cough = value;
                  }),
              CheckBoxRow(
                  initialValue: jointPain,
                  textState: "ألم مفاصل",
                  onChange: (value) {
                    jointPain = value;
                  }),
              Align(
                  alignment: Alignment.center,
                  child: ButtonWidget(
                    buttonName: " حفظ المعلومات ",
                    buttonColor: Colors.blue,
                    onClick: addOrUpdatePatient,
                    size: Size(50.w, 10.w),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  stomachacheAdditions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NormalTextField(
            styleColor: Colors.black,
            labelText: "بدايته",
            icon: Icons.restart_alt,
            textInputType: TextInputType.text,
            borderColor: Colors.red,
            hintText: "بداية الألم البطني",
            controller: stomachachePainIntensityController,
            onChange: () {
            }),
        SimpleDropDownWidget(onChanged: (value) {
          intensity = value;
          print(intensity);
        }, initialValue: intensity == "" ? null : intensity,)
      ],
    );
  }

  ProfileImageWidget() {
    return Row(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              ImageSettings();
            },
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.black , width: 2.sp),
              borderRadius: BorderRadius.circular(15)
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: profile != "" ? Image.memory(imageDecoder() , width: 40.w, height: 40.w  , fit: BoxFit.fill,) : Icon(Icons.add_a_photo_outlined , size: 40.sp,)
            ),
          ),)
        ],
      );
  }

  void ImageSettings() {
    showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView(
      child: Container(
         padding: EdgeInsets.only(bottom: 2.0.w , top: 2.0.w),
         child: Column(
           children: [
             ListTile(
               trailing: Text("إضافة صورة" , style: TextStyle(fontSize: 15.sp ,)),
               leading: Icon(Icons.image, color: Colors.red),
               onTap: (){
                 pickImage();
                 Navigator.pop(context);
               },
             ),
             profile != "" ? ListTile(
               trailing: Text("حذف الصورة الحالية" , style: TextStyle(fontSize: 15.sp ,)),
               leading: Icon(Icons.delete , color: Colors.red,),
               onTap: (){
                   setState(() {
                     image = null;
                     profile = "";
                   });
                   Navigator.pop(context);
               },
             ): Container()
           ],
         ),
      ) ,
    ));
  }

    imageDecoder() {
      return Base64Decoder().convert(profile);
    }
}
