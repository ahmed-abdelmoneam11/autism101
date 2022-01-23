import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Constants.dart';

class VerifySchools extends StatefulWidget {
  @override
  _VerifySchoolsState createState() => _VerifySchoolsState();
}

class _VerifySchoolsState extends State<VerifySchools> {
  List schoolsData = [];
  List verfication = [];
  late AdminBloc adminBloc;
  var schools;

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    adminBloc.add(GetSchoolsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Schools",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
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
          } else if (state is GetSchoolsSuccessState) {
            setState(() {
              schools = state.schools;
            });
          } else if (state is GetSchoolsErrorState) {
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
        child: StreamBuilder<QuerySnapshot>(
          stream: schools,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final schoolsDB = snapshot.data!.docs;
            for (var school in schoolsDB) {
              final webSite = school.get('website');
              final address = school.get('address');
              schoolsData.add(
                {
                  'WebSite': webSite,
                  'Address': address,
                },
              );
              verfication.add(false);
            }
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  Icons.school,
                  size: 40.0,
                ),
                title: Text(
                  '${schoolsData[index]['WebSite']}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    if (!verfication[index]) {
                      adminBloc.add(
                        VerifySchoolEvent(
                          webSite: schoolsData[index]['WebSite'],
                        ),
                      );
                      setState(() {
                        verfication[index] = true;
                      });
                    }
                  },
                  child: Text(verfication[index] ? "Verified" : "Verify"),
                ),
                subtitle: Text(
                  '${schoolsData[index]['Address']}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
