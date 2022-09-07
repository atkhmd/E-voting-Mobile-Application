import 'package:flutter/material.dart';
import 'package:mobilevote/Admin/fpaList.dart';
import 'package:mobilevote/Admin/fskmList.dart';
import 'package:mobilevote/Admin/home_admin.dart';

class CandidatesList extends StatefulWidget {
  const CandidatesList({Key? key}) : super(key: key);

  @override
  _CandidatesListState createState() => _CandidatesListState();
}

class _CandidatesListState extends State<CandidatesList>
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
          title: const Text('List of Candidates'),
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(text: 'FSKM'),
              Tab(text: 'FPA'),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeAdmin()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Colors.black,
            ),
          ),
        ),
        body: TabBarView(controller: controller, children: const [
          FskmList(),
          FpaList(),
        ]),
      );
}
