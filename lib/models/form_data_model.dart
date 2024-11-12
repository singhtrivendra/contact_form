class FormDataModel {
  int? genderId;
  int? age;
  String? selfiePath;
  String? audioPath;
  String? gpsCoordinates;
  String? submissionTime;

  FormDataModel({
    this.genderId,
    this.age,
    this.selfiePath,
    this.audioPath,
    this.gpsCoordinates,
    this.submissionTime,
  });

  Map<String, dynamic> toJson() => {
        'Q1': genderId,
        'Q2': age,
        'Q3': selfiePath,
        'recording': audioPath,
        'gps': gpsCoordinates,
        'submit_time': submissionTime,
      };
}
