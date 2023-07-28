import 'dart:convert';

import 'package:newsapi/Model/Article.dart';
import 'package:http/http.dart';

class ApiServices{
  final endPoint = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=5617262337af427494f8140d012011e6";

  Future<List <Article>> getArticles() async{
    Response response = await get(Uri.parse(endPoint));

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> article = body['articles'];
      List<Article> data = article.map((dynamic items) => Article.fromJson(items)).toList();
      return data;
    }else{
      throw ("Can't fetch Data !");
    }
  }
}