class SliderModel {
  final String imageUrl;

  SliderModel.fromJson(Map<String, dynamic> json) : imageUrl = json['image'];

  SliderModel(this.imageUrl);
}
