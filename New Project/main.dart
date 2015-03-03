  import 'package:http/http.dart' as http;
  import 'package:xmlstream/xmlstream.dart';


void main() {


  /* URL de la marque */
  var url = "http://www.automobile-catalog.com/auta_ddl.php?id=MARKA%3Aaudi";
  /* URL du sous modele
   * "http://www.automobile-catalog.com/auta_ddl.php?id=MODEL%3Aa3_concept"
   */
  var reponse = null;
  http.read(url).then((reponse) => populateItem(reponse));
  

}

populateItem(String reponse) {
  var xmlStreamer = new XmlStreamer(reponse);
  
  var xmlObjectBuilder = new XmlObjectBuilder<Item>(xmlStreamer, new ItemProcessor());
  
  xmlObjectBuilder.onProcess().listen((e) => print("listen: $e"));
  
  
}


class ItemProcessor extends XmlProcessor<Item> {
  
  ItemProcessor() {
    tagName = "option";
  }
  
  void onOpenTag(String tag) {
     element = new Item();
  }
  
  void onAttribute(String key, String value) {
    if (key == "id") {
      element.name = value;
    }
  }

  void onCharacters(String text) {
    element.value = text;
  } 
}

class Item {
  String name;
  String value;
  
  String toString() => "$name - $value";
}