final String table = "patients";

class PatientFields{

  static final List<String> values = [
    //all fields
    id , age , phoneNumber , name , address , time ,weight , stomachachePainIntensity , stomachache , vomiting , jointPain , fever , diarrhea , cough , intensity , profile
  ];


  //Column names of our table
  static final String id = "_id";
  static final String age = "age";
  static final String phoneNumber = "phoneNumber";
  static final String name = "name";
  static final String address = "address";
  static final String time = "time";
  static final String weight = "weight";
  static final String stomachachePainIntensity = "stomachachePainIntensity";
  static final String stomachache = "stomachache";
  static final String vomiting = "vomiting";
  static final String jointPain = "jointPain";
  static final String fever = "fever";
  static final String diarrhea = "diarrhea";
  static final String cough = "cough";
  static final String intensity = "intensity";
  static final String profile = "profile";



}

class Patient{
//Fields we want to storage
  late final int? id;
  late final int age;
  late final int phoneNumber;
  late final String name;
  late final String address;
  late final DateTime createdTime;
  late final String weight;
  late final String stomachachePainIntensity;
  late final bool stomachache;
  late final bool vomiting;
  late final bool jointPain;
  late final bool fever;
  late final bool diarrhea;
  late final bool cough;
  late final String intensity;
  late final String profile;


  Patient(
      {
        this.id,
        required this.age,
        required this.phoneNumber,
        required this.name,
        required this.address,
        required this.createdTime,
        required this.weight,
        required this.stomachachePainIntensity,
        required this.stomachache,
        required this.vomiting,
        required this.jointPain,
        required this.fever,
        required this.diarrhea,
        required this.cough,
        required this.intensity,
        required this.profile
});

  Map<String , Object?> toJson() =>{
    PatientFields.id: id,
    PatientFields.age: age,
    PatientFields.phoneNumber: phoneNumber,
    PatientFields.name: name,
    PatientFields.address: address,
    PatientFields.stomachachePainIntensity: stomachachePainIntensity,
    PatientFields.weight : weight,
    PatientFields.stomachache: stomachache ? 1 :0,
    PatientFields.jointPain: jointPain ? 1 :0,
    PatientFields.fever: fever ? 1 :0,
    PatientFields.diarrhea: diarrhea ? 1 :0,
    PatientFields.vomiting: vomiting ? 1 :0,
    PatientFields.cough: cough ? 1 :0,
    PatientFields.intensity: intensity,
    PatientFields.profile: profile,
    PatientFields.time: createdTime.toIso8601String(), //we parse date to be String in json
  };

  static Patient fromJson(Map<String, Object?> json) => Patient(
    id:  json[PatientFields.id] as int?,
    age: json[PatientFields.age] as int,
    phoneNumber: json[PatientFields.phoneNumber] as int ,
    name: json[PatientFields.name] as String ,
    address: json[PatientFields.address] as String ,
    createdTime: DateTime.parse(json[PatientFields.time] as String),
    stomachachePainIntensity: json[PatientFields.stomachachePainIntensity] as String,
    weight: json[PatientFields.weight] as String,
    stomachache: json[PatientFields.stomachache] == 1 ? true : false,
    cough: json[PatientFields.cough] == 1 ? true : false,
    vomiting: json[PatientFields.vomiting] == 1 ? true : false,
    diarrhea: json[PatientFields.diarrhea] == 1 ? true : false,
    fever: json[PatientFields.fever] == 1 ? true : false,
    jointPain: json[PatientFields.jointPain] == 1 ? true : false,
    intensity: json[PatientFields.intensity] as String,
    profile: json[PatientFields.profile] as String,
  );

  Patient copy({
    int?  id,
    int? age,
    int? phoneNumber,
    String? name,
    String? address,
    DateTime? createdTime,
    String? weight,
    String? stomachachePainIntensity,
    bool? stomachache ,
    bool? vomiting ,
    bool? jointPain ,
    bool? fever,
    bool? diarrhea,
    bool? cough,
    String? intensity,
    String? profile
  }) => Patient(
    id: id ?? this.id,
    age: age ?? this.age,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    name: name ?? this.name,
    address: address ?? this.address,
    createdTime: createdTime ?? this.createdTime,
    jointPain: jointPain ?? this.jointPain,
    stomachache: stomachache ?? this.stomachache,
    diarrhea: diarrhea ?? this.diarrhea,
    fever: fever ?? this.fever,
    vomiting: vomiting ?? this.vomiting,
    cough: cough ?? this.cough,
    intensity: intensity ?? this.intensity,
    weight: weight ?? this.weight,
    stomachachePainIntensity: stomachachePainIntensity ?? this.stomachachePainIntensity,
    profile: profile ?? this.profile
  );

}