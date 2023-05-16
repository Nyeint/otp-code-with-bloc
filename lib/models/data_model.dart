class DataModel {
  String? code;
  Meta? meta;

  DataModel({this.code, this.meta});

  DataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? method;
  String? bit;
  String? mode;
  String? secretKey;

  Meta({this.method, this.bit, this.mode, this.secretKey});

  Meta.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    bit = json['bit'];
    mode = json['mode'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['bit'] = this.bit;
    data['mode'] = this.mode;
    data['secretKey'] = this.secretKey;
    return data;
  }
}