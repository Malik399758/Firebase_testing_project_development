
class ContentModel{
  final String title;
  final String description;

  ContentModel({
    required this.title,
    required this.description
});

  // model to map

 Map<String ,dynamic> toMap(){
   return {
     'title' : title,
     'description' : description
   };
 }

 // map to model

 factory ContentModel.fromMap(Map<String,dynamic> map){
   return ContentModel(
       title: map['title'],
       description: map['description']
   );
 }

  void operator [](int other) {}
}