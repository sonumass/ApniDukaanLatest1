class LoginInputModel {
  String mobile;
  String googleId;
  String type;
  bool termAndCondition=false;

  LoginInputModel(
      {required this.mobile, required this.googleId, required this.type,this.termAndCondition=false});

  Map toJson() => {'mobile': mobile, 'googleId': googleId, 'type': type,'termAndCondition':termAndCondition};
}
