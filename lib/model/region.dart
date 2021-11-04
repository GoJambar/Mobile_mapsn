class ListRegionReponse {
  int? id;
  String? codeRegion;
  String? name;
  String? photo;
  int? superficie;
  int? population;
  double? latitude;
  double? longitute;
  String? detail;
  List<Depart>? depart;

  ListRegionReponse(
      {this.id,
      this.codeRegion,
      this.name,
      this.photo,
      this.superficie,
      this.population,
      this.latitude,
      this.longitute,
      this.detail,
      this.depart});

  ListRegionReponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeRegion = json['codeRegion'];
    name = json['name'];
    photo = json['photo'];
    superficie = json['superficie'];
    population = json['population'];
    latitude = json['latitude'];
    longitute = json['longitute'];
    detail = json['detail'];
    if (json['depart'] != null) {
      depart = [];
      json['depart'].forEach((v) {
        depart?.add(Depart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codeRegion'] = this.codeRegion;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['superficie'] = this.superficie;
    data['population'] = this.population;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['detail'] = this.detail;
    if (this.depart != null) {
      data['depart'] = this.depart?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Depart {
  int? id;
  String? codeDep;
  String? name;
  double? superficie;
  int? population;
  double? latitude;
  double? longitute;
  String? detail;
  List<Arron>? arron;

  Depart(
      {this.id,
      this.codeDep,
      this.name,
      this.superficie,
      this.population,
      this.latitude,
      this.longitute,
      this.detail,
      this.arron});

  Depart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeDep = json['codeDep'];
    name = json['name'];
    superficie = json['superficie'];
    population = json['population'];
    latitude = json['latitude'];
    longitute = json['longitute'];
    detail = json['detail'];
    if (json['arron'] != null) {
      arron = [];
      json['arron'].forEach((v) {
        arron!.add(new Arron.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codeDep'] = this.codeDep;
    data['name'] = this.name;
    data['superficie'] = this.superficie;
    data['population'] = this.population;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['detail'] = this.detail;
    if (this.arron != null) {
      data['arron'] = this.arron?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Arron {
  int? id;
  String? codeAr;
  String? name;
  double? superficie;
  double? population;
  double? latitude;
  double? longitute;
  String? detail;
  List<Commun>? commun;

  Arron(
      {this.id,
      this.codeAr,
      this.name,
      this.superficie,
      this.population,
      this.latitude,
      this.longitute,
      this.detail,
      this.commun});

  Arron.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeAr = json['codeAr'];
    name = json['name'];
    superficie = json['superficie'];
    population = json['population'];
    latitude = json['latitude'];
    longitute = json['longitute'];
    detail = json['detail'];
    if (json['commun'] != null) {
      // ignore: deprecated_member_use
      commun = [];
      json['commun'].forEach((v) {
        commun!.add(new Commun.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codeAr'] = this.codeAr;
    data['name'] = this.name;
    data['superficie'] = this.superficie;
    data['population'] = this.population;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['detail'] = this.detail;
    if (this.commun != null) {
      data['commun'] = this.commun?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commun {
  int? id;
  String? codeCom;
  String? name;
  double? superficie;
  double? population;
  double? latitude;
  double? longitute;
  String? detail;

  Commun(
      {this.id,
      this.codeCom,
      this.name,
      this.superficie,
      this.population,
      this.latitude,
      this.longitute,
      this.detail});

  Commun.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeCom = json['codeCom'];
    name = json['name'];
    superficie = json['superficie'];
    population = json['population'];
    latitude = json['latitude'];
    longitute = json['longitute'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codeCom'] = this.codeCom;
    data['name'] = this.name;
    data['superficie'] = this.superficie;
    data['population'] = this.population;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['detail'] = this.detail;
    return data;
  }
}
