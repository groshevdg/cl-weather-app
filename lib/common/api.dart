class Api {
  static const _weatherApiKey = '5eb7fd16fb55ae618854b62fce2283ca';
  static const _cityApiKey = 'uRtKnACNk2oUORVduXZGnVbmz6plnYEx';
  static String weatherInfo(String latitude, String longitude) =>
      'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&appid=$_weatherApiKey';
  static String cityName(String latitude, String longitude) =>
      'https://api.tomtom.com/search/2/reverseGeocode/$latitude,$longitude.json?key=$_cityApiKey';
}
