import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_models.dart';
import 'package:news/models/category_model.dart';
import 'package:news/views/article_view.dart';
import 'package:news/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading =true;

  @override
  void initState() {
    super.initState();
    categories= getCategories();
    getNews();
  }
  getNews()async
  {
    News newsClass = News();
    await newsClass.getNews();
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
      ),
      body:_loading?Center(child: Container(child: CircularProgressIndicator(),)):
      SingleChildScrollView(
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: Column(
         children: [
   ///categories
         Container(
           padding:  EdgeInsets.symmetric(horizontal: 16),
           height: 70.0,
              child: ListView.builder(
                shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context,index){
                return CategoryTile(
                categoryName: categories[index].categoryName,
                imageUrl: categories[index].imageUrl,
                );
               }),
              ),
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
        ),
    ),
      ));
  }
}

class CategoryTile extends StatelessWidget {
  final String  imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CategoryNews(
              category: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
Container(
alignment: Alignment.center,
  width: 120,height: 60,
  decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(6),
      color: Colors.black26,
  ),
  child: Text(
        categoryName,style: TextStyle(
        color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14
  ),
  ),
)

          ],
        ),
      ),
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

