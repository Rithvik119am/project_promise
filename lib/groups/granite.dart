class GraniteOrder {
  String name;
  int numberOfSlabs;
  double squareFeet;
  double perSqurare = 0.0;
  double price = 0.0;
  List<Pair>? dimensions = [];

  GraniteOrder({
    required this.name,
    required this.numberOfSlabs,
    required this.squareFeet,
  });
  set setName(String newName) {
    name = newName;
  }

  void setSquareFeetWithDimentions() {
    squareFeet = 0;
    for (var i in dimensions!) {
      squareFeet += i.squareFeet();
    }
  }

  void calculatePrice() {
    price = perSqurare * squareFeet;
  }

  set setNumberOfSlabs(int newNumberOfSlabs) {
    numberOfSlabs = newNumberOfSlabs;
  }

  map(Map<String, dynamic> Function(dynamic graniteOrder) param0) {}

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberOfSlabs': numberOfSlabs,
      'squareFeet': squareFeet,
      'perSqurare': perSqurare,
      'price': price,
    };
  }

  static GraniteOrder fromJsonDatabase(Map<String, dynamic> data) {
    final temp = GraniteOrder(
      name: data['granite_name'],
      numberOfSlabs: data['no_of_slabs'],
      squareFeet: (data['squareFeet'] as num).toDouble(),
    );
    temp.perSqurare = (data['perSFT'] as num).toDouble();
    temp.price = (data['granite_order_value'] as num).toDouble();
    return temp;
  }

  Map<String, dynamic> toJsonDatabase(String id) {
    return {
      'granite_name': name,
      'no_of_slabs': numberOfSlabs,
      'squareFeet': squareFeet,
      'perSFT': perSqurare,
      'granite_order_value': price,
      'coustomer': id,
    };
  }
}

class Pair<T1, T2> {
  T1 first;
  T2 second;

  Pair(this.first, this.second);
  double squareFeet() {
    return (first as double) * (second as double) / 144;
  }
}
