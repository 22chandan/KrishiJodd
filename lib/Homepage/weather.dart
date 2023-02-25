class Weather {
  double? tempC;
  final String condition;
  final String iconVal;
  Weather({this.tempC = 0, this.condition = "Sunny", this.iconVal = ''});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      tempC: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      iconVal: json['current']['condition']['icon'],
    );
  }
}
