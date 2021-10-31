class Region {
  String? codeRegion;
  String name;
  String photo;
  double superficie;
  double population;
  double latitude;
  double longitute;
  String detail;

  Region(
      {required this.codeRegion,
      required this.name,
      required this.photo,
      required this.superficie,
      required this.population,
      required this.latitude,
      required this.longitute,
      required this.detail});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
        codeRegion: json['codeRegion'],
        name: json['name'],
        photo: json['photo'],
        superficie: json['superficie'],
        population: json['population'],
        latitude: json['latitude'],
        longitute: json['longitute'],
        detail: json['detail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codeRegion'] = this.codeRegion;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['superficie'] = this.superficie;
    data['population'] = this.population;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['detail'] = this.detail;
    return data;
  }
}
