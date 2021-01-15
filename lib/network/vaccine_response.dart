class VaccineReponse {
  int total;
  int today;

  VaccineReponse({this.total, this.today});

  VaccineReponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    today = json['today'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['today'] = this.today;
    return data;
  }
}
