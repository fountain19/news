import 'dart:convert';
import 'package:news/models/article_models.dart';
import 'package:http/http.dart'as http;
class News
{
  List<ArticleModel> news = [];
  Future<void> getNews()async
  {
    String url='http://newsapi.org/v2/top-headlines?country=tr&apiKey=95d00b8452d44d1895c6d2e300e0c695';
    var response=await http.get(url);
    var jsonData= jsonDecode(response.body);
    if(jsonData['status']=='ok')
    {
      jsonData['articles'].forEach((element)
      {
        if(element['urlToImage']!= null && element['description'] != null)
        {
          ArticleModel articleModel =ArticleModel(
            title: element['title'],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            content: element['content'],

          );
          news.add(articleModel);
        }
      });

    }
  }
}

class CategoryNewsClass
{
  List<ArticleModel> news = [];
  Future<void> getNews(String category)async
  {
    String url='http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=95d00b8452d44d1895c6d2e300e0c695';
    var response=await http.get(url);
    var jsonData= jsonDecode(response.body);
    if(jsonData['status']=='ok')
    {
      jsonData['articles'].forEach((element)
      {
        if(element['urlToImage']!= null && element['description'] != null)
        {
          ArticleModel articleModel =ArticleModel(
            title: element['title'],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            content: element['content'],

          );
          news.add(articleModel);
        }
      });

    }
  }
}