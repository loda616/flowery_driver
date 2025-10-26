class UpdateOrderDetailsRequestBody {
  UpdateOrderDetailsRequestBody({
      this.state,});

  UpdateOrderDetailsRequestBody.fromJson(dynamic json) {
    state = json['state'];
  }
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    return map;
  }

}