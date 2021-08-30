class Api {
  static String weatherInfo(String latitude, String longitude, String apiKey) =>
      'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey';
  static String cityName(String latitude, String longitude, String apiKey) =>
      'https://api.tomtom.com/search/2/reverseGeocode/$latitude,$longitude.json?key=$apiKey';
}
