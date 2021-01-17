class Cryptography {
  final String name;
  final String key;
  final String text;

  Cryptography(this.name, this.key, this.text);
}

List<Cryptography> categories = categoriesData
    .map((item) => Cryptography(item['name'], item['key'], item['text']))
    .toList();

var categoriesData = [
  {"name": "Polybius Cipher without numbers", "key": "0", "text": "Input text:"},
  {"name": "Polybius Cipher with numbers", "key": "1", "text": "Input text:"},
];
//---------------------------------------------
class DebugMode {
  bool switchdebug;
  

  DebugMode(this.switchdebug);
}

List<DebugMode> debug = debugData
    .map((item) => DebugMode(item['switchdebug']))
    .toList();

var debugData = [
  {"switchdebug": false},
];