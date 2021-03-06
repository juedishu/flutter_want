import 'package:flutter/material.dart';

class TabAppBar extends StatelessWidget {
  const TabAppBar({this.tabs, this.controller, this.title});

  final List<String> tabs;

  final TabController controller;

  final String title;

  Widget buildAppBar(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new Container(
        child: Row(
          children: <Widget>[
            InkResponse(
              child: Container(
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        height: 50,
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
        width: double.infinity,
        child: TabBar(
          isScrollable: true,
          controller: this.controller,
          labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black45,
          indicatorColor: Colors.blue,
          indicatorWeight: 2,
          tabs: tabs.map((item) {
            return Container(
              height: 30,
              child: Center(child: Text(item)),
            );
          }).toList(),
        ));
  }

  @override
  PreferredSize build(BuildContext context) {
    return new PreferredSize(
      child: Column(
        children: tabs != null && tabs.length > 0
            ? [buildAppBar(context), buildTabBar()]
            : [buildAppBar(context)],
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        tabs != null && tabs.length > 0 ? 82 : 50,
      ),
    );
  }
}
