class VaccineReponse {
  int total;
  int yesterday;

  VaccineReponse({this.total, this.yesterday});

  VaccineReponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    yesterday = json['yesterday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['yesterday'] = this.yesterday;
    return data;
  }
}
