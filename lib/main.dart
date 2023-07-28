import 'package:flutter/material.dart';
import 'package:newsapi/Services/ApiServices.dart';
import 'Model/Article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App', style: TextStyle(color: Colors.white),)),
      body: FutureBuilder(
        future: ApiServices().getArticles(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, index) {
                final article = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(article: article),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('${article.title}'),
                      subtitle: Text(
                        '${article.description}',
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      leading: article.urlToImage != null
                          ? Image.network(article.urlToImage!)
                          : Placeholder(), // You can customize the placeholder image or omit it
                    ),
                  ),
                );
              },
            );

          }return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(article.urlToImage!),
            SizedBox(height: 16),
            Text(
              article.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (article.author != null)
              Text('Author: ${article.author}'),
            SizedBox(height: 8),
            Text(article.description),
          ],
        ),
      ),
    );
  }
}


