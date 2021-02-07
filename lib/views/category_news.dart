import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_models.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading =true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews()async
  {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'News'.toUpperCase(),style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: _loading?Center(child: Container(child: CircularProgressIndicator(),)):
      SingleChildScrollView(
        child: Container(
            padding:  EdgeInsets.symmetric(horizontal: 16),
    child: Column(
        children: [
          /// Blogs
          Container(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context,index){
                  return BlogTile(
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].description,
                    url: articles[index].url,
                  );
                }),
          )
        ],
    )),
      )
    );
  }
}
class BlogTile extends StatelessWidget {
  final String desc,imageUrl,title,url;
  BlogTile({@required this.imageUrl,@required this.title,
    @required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ArticleView(
                blocUrl:url
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(
                color: Colors.black87,fontSize: 17,
                fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(
              color: Colors.black54,
            ),)
          ],
        ),
      ),
    );
  }
}