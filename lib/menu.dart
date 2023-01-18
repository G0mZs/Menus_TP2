class Menu {
  String img;
  String weekDay;
  String soup;
  String fish;
  String meat;
  String vegetarian;
  String desert;
  bool update;

  Menu(
      {required this.img,
        required this.weekDay,
        required this.soup,
        required this.fish,
        required this.meat,
        required this.vegetarian,
        required this.desert,
        required this.update});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        img: "null",
        weekDay: json["weekDay"].toString(),
        soup: json["soup"].toString(),
        fish: json["fish"].toString(),
        meat: json["meat"].toString(),
        vegetarian: json["vegetarian"].toString(),
        desert: json["desert"].toString(),
        update: false
    );
  }

}