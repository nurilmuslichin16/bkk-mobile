class CekLokerModel {
  bool status = false;

  CekLokerModel({this.status});

  factory CekLokerModel.createObject(Map<String, dynamic> object) {
    return CekLokerModel(status: object['status']);
  }
}
