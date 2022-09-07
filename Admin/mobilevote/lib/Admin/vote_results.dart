import 'package:flutter/material.dart';
import 'package:mobilevote/Admin/fpa_page.dart';
import 'package:mobilevote/Admin/fskm_page.dart';

class VoteResults extends StatefulWidget {
  const VoteResults({Key? key}) : super(key: key);

  @override
  _VoteResultsState createState() => _VoteResultsState();
}

class _VoteResultsState extends State<VoteResults>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
  }

  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          // ignore: deprecated_member_use
          brightness: Brightness.light,
          backgroundColor: Colors.lightBlue,
          title: const Text('Vote Results'),
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(text: 'FSKM'),
              Tab(text: 'FPA'),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Colors.black,
            ),
          ),
        ),
        body: TabBarView(controller: controller, children: const [
          FskmPage(),
          FpaPage(),
        ]),
      );
}
