class Intro {
  Intro({
    required this.brands,
    required this.colors,
  });
  late final List<Brands> brands;
  late final List<Colors> colors;

  Intro.fromJson(Map<String, dynamic> json){
    brands = List.from(json['brands']).map((e)=>Brands.fromJson(e)).toList();
    colors = List.from(json['colors']).map((e)=>Colors.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['brands'] = brands.map((e)=>e.toJson()).toList();
    _data['colors'] = colors.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Brands {
  Brands({
    required this.id,
    required this.title,
    required this.image,
    required this.models,
  });
  late final int id;
  late final String title;
  late final String image;
  late final List<Models> models;

  Brands.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    models = List.from(json['models']).map((e)=>Models.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['models'] = models.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Models {
  Models({
    required this.id,
    required this.title,
    required this.brandId,
  });
  late final int id;
  late final String title;
  late final int brandId;

  Models.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    brandId = json['brand_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['brand_id'] = brandId;
    return _data;
  }
}

class Colors {
  Colors({
    required this.id,
    required this.title,
  });
  late final int id;
  late final String title;

  Colors.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    return _data;
  }
}