import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/search_result.dart';
import 'package:reddit_attempt2/Services/firestore.dart';


class postTo extends StatelessWidget {
   postTo({super.key});
      final FirestoreService firestore= FirestoreService();


  @override
  Widget build(BuildContext context) {
    TextEditingController post_To = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.cancel_sharp, color: Colors.black,)),
        title: const Text("Post to", style: TextStyle(color: Colors.black),)
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  const Icon(Icons.search),
                  Expanded(
                    child: TextField(
                      controller: post_To,
                      decoration: const InputDecoration(
                        hintText: 'Search for a community',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
              ),
          ),

           
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Community>>(
                    future: firestore.fetchcommunity(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text("No communities found.");
                      } else {
                        final communities = snapshot.data!;
                        return ListView.builder(
                          itemCount: communities.length,
                          itemBuilder: (context, index) {
                            final c = communities[index];
                            return SearchResult(
                              name: c.name,
                              description: c.description,
                              adult: c.adult,
                              ontap: () {
                                print("Tapped ${c.name}");
                              },
                            );
                          },
                        );
                  }
                              },
                            ),
                ),
              )

        ],
      ),
    );
  }
}