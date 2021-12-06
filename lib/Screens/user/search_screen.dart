import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/flush_bar.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late ProfileBloc profileBloc;
  late TextEditingController _searchQueryController = TextEditingController();
  List usersList = [];
  var users;

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextField(
          controller: _searchQueryController,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
          decoration: InputDecoration(
            hintText: "Enter User Name...",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: search,
            icon: Icon(
              CupertinoIcons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is SearchUsersErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is SearchUsersSuccessState) {
            setState(() {
              users = state.users;
            });
          }
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: users,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            final usersData = snapshot.data!.docs;
            for (var user in usersData) {
              final userFirstName = user.get('firstName');
              final userLastName = user.get('lastName');
              final userPictureUrl = user.get('ProfilePicture');
              final userDocId = user.id;

              usersList.add(
                {
                  "userName": '$userFirstName $userLastName',
                  "ProfilePicture": userPictureUrl,
                  "userDocId": userDocId,
                },
              );
            }
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading:
                            //image of the owner of the post
                            ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            usersList[index]['ProfilePicture'],
                            height: 60.0,
                            width: 60.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          '${usersList[index]['userName']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileView(
                                userDocId: usersList[index]['userDocId'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "No User Found That Name !",
                    ),
                  );
          },
        ),
      ),
    );
  }

  void search() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_searchQueryController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Search field can't be empty !",
        message: "Please enter a user name.",
        icons: Icons.signal_wifi_off,
      );
    } else {
      profileBloc.add(
        SearchUsers(
          query: _searchQueryController.text,
        ),
      );
    }
  }
}
