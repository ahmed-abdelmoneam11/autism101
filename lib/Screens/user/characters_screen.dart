import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Screens/admin/admin_home.dart';

class Screens extends StatefulWidget {
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
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  late AdminBloc adminBloc;

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white.withOpacity(0.4),
      appBar: AppBar(
        title: Text(
          widget.name,
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
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminLodingState) {
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
          } else if (state is DeleteInspiringSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHome(),
              ),
            );
          } else if (state is DeleteInspiringErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(200),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.date,
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
                        '${widget.brief}',
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
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: deleteInspiring,
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

  deleteInspiring() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            "Sign Out",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              height: 1.3,
            ),
          ),
          content: Text(
            "Are you sure? deleting people will remove this people permanently.",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
              height: 1.3,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                adminBloc.add(
                  DeleteInspiring(name: widget.name),
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
