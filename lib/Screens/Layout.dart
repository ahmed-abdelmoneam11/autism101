import 'dart:ui';

import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final Widget _widg;
  const Layout(this._widg, {Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 0, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  ' Welcome to',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Autism',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                                Transform.rotate(
                                  angle: 6.7,
                                  child: Icon(
                                    Icons.accessibility_new_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                          ),
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.dstATop),
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                        ),
                        child: widget._widg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
