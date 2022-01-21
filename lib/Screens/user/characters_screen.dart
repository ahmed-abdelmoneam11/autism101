import 'package:flutter/material.dart';

class Screens extends StatelessWidget {
  final name;
  final brief;
  final date;
  final autismCase;
  final imageUrl;
  final bool isAdmin;

  Screens({
    required this.name,
    required this.brief,
    required this.date,
    required this.autismCase,
    required this.imageUrl,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white.withOpacity(0.4),
      appBar: AppBar(
        title: Text(
          name,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(200),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '$brief',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.all(
                  15.0,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 35.0,
              ),
              backgroundColor: Colors.red,
            )
          : null,
    );
  }
}
