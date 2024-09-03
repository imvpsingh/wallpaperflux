class WallpaperModel {
  late String? photographer;
  late String? photographer_url;
  late int? photographer_id;
  late SrcModel? src;

  WallpaperModel(
      { this.photographer,  this.photographer_id,  this.photographer_url,  this.src});
  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(photographer : jsonData["photographer"], photographer_id : jsonData["photographer_id"], photographer_url : jsonData["photographer_url"], src : SrcModel.fromMap( jsonData["src"]));
  }
}

class SrcModel {
  late String? original;
  late String? small;
  late String? portrait;

  SrcModel({ this.original,  this.portrait,  this.small});
  factory SrcModel.fromMap(Map<String,dynamic> jsonData){
    return SrcModel(original : jsonData["original"], small : jsonData["small"], portrait : jsonData["portrait"]);
  }
}
