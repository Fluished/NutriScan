import 'package:flutter/material.dart';
import '../../models/health_tips_model.dart';
import '../../services/health_tips_service.dart';

class HealthyTipsScreen extends StatefulWidget {
  const HealthyTipsScreen({super.key});

  @override
  State<HealthyTipsScreen> createState() => _HealthyTipsScreenState();
}

class _HealthyTipsScreenState extends State<HealthyTipsScreen> {
  final HealthTipsService _service = HealthTipsService();
  late Future<List<HealthArticle>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = _service.fetchHealthArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<HealthArticle>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Text('Failed to load articles'));

          final articles = snapshot.data!;
          final latest = articles.take(2).toList();
          final rest = articles.skip(2).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text("Latest Articles Added", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: latest.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final article = latest[index];
                    return Stack(
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(article.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              article.title,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ...rest.map((article) => Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
            ],
          );
        },
      ),
    );
  }
}