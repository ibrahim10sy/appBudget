import 'package:ika_musaka/model/categorie.dart';
import 'package:http/http.dart' as http;

class CategorieService {

  Future<List<Categorie>?> getCategories() async{
      var client = http.Client();
      var uri=  Uri.parse('http://localhost:8080/Categorie');
      var response = await client.get(uri);
      if(response.statusCode ==200){
        var json= response.body;
         categorieFromJson(json);
      }
  }
}