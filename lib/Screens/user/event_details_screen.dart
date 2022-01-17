import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:autism101/Constants.dart';

class EventDetails extends StatefulWidget {
  final String eventName;
  final String eventImage;
  final String eventLink;
  final String eventBio;
  EventDetails({
    required this.eventName,
    required this.eventImage,
    required this.eventLink,
    required this.eventBio,
  });
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.eventName}',
          style: TextStyle(
            fontFamily: "Futura",
            color: Colors.black,
            fontSize: 20.0,
          ),
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
          SizedBox(
            height: 15.0,
          ),
          //Event Image.
          Container(
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.all(
              8.0,
            ),
            child: Image.network(
              '${widget.eventImage}',
              fit: BoxFit.fill,
            ),
          ),
          //Event Data.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description:",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  '${widget.eventBio}',
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                  color: Colors.black,
                  indent: 2.0,
                  endIndent: 2.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Link:",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: () async {
                    if (await canLaunch(widget.eventLink)) {
                      await launch(widget.eventLink);
                    } else {
                      throw 'Could not launch ${widget.eventLink}';
                    }
                  },
                  child: Text(
                    '${widget.eventLink}',
                    style: LinkStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
