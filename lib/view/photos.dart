import 'package:flutter/material.dart';
import '../service.dart';
import '../models/photo.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => PhotosPageState();
}

class PhotosPageState extends State<PhotosPage> {
  final PhotoService photoService = PhotoService();
  String searchQuery = 'cat';
  int currentPage = 1;
  final TextEditingController searchController = TextEditingController(
    text: 'cat',
  );
  late Future<List<Photo>> photosFuture;

  @override
  void initState() {
    super.initState();
    photosFuture = photoService.searchPhotos(searchQuery, page: currentPage);
  }

  void search() {
    setState(() {
      searchQuery = searchController.text;
      currentPage = 1;
      photosFuture = photoService.searchPhotos(searchQuery, page: currentPage);
    });
  }

  void nextPage() {
    setState(() {
      currentPage++;
      photosFuture = photoService.searchPhotos(searchQuery, page: currentPage);
    });
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        photosFuture = photoService.searchPhotos(
          searchQuery,
          page: currentPage,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash Photos'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search photos...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    onSubmitted: (_) => search(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: search,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: photosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final photos = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                photo.thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Page $currentPage',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: previousPage,
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: nextPage,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
