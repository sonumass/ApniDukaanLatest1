class ApplyInsauranceInput {
  String address;
  String email;
  String loanAmount;
  String cropAmount;
  String message;
  String name;
  String phone;

  ApplyInsauranceInput(
      {required this.address,
      required this.email,
      required this.loanAmount,
      required this.cropAmount,
      required this.message,
      required this.name,
      required this.phone});

  Map toJson() => {
        'address': address,
        'email': email,
        'loanAmount': loanAmount,
        'cropAmount': cropAmount,
        'message': message,
        'name': name,
        'phone': phone
      };
}
