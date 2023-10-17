import 'package:flutter/foundation.dart';

class CategoriesProvider with ChangeNotifier{
     List<dynamic> _categories = [];

   List<dynamic> get categories => _categories;
   void setCategorie(dynamic categories){

        _categories = categories;
         notifyListeners();
   }
   List<dynamic> getCategories(){
    return _categories;
   }

    void addItem(dynamic category) {
    _categories.add(category);
    notifyListeners();
  }

  void editItem(int index,dynamic category){
    _categories[index] = category;
    notifyListeners();
  }
   void removeCategory(int index){
     // _categories = [];
      _categories.removeAt(index);
      print("removedddd");
      notifyListeners();
   }

}