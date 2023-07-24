class ApplyTrainingInput {
  int id;
  String name;
  String email;
  String phone;
  String discription;
  String trainingType;
  String trainingMode;
  String trainingVenue;
  String trainingDate;

  ApplyTrainingInput(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.discription,
      required this.trainingType,
      required this.trainingMode,
      required this.trainingVenue,
      required this.trainingDate});

  Map toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'phone': phone,
        'discription': discription,
        'trainingType': trainingType,
        'trainingMode': trainingMode,
        'trainingVenue': trainingVenue,
        'trainingDate': trainingDate,
      };
}
