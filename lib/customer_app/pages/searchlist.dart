import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:provider/provider.dart';

class Model {
  String id;
  String name;
  String title;

  Model({required this.id, required this.name, required this.title});
}

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = const Text(
    "Search Demo",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.orange,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  static final List<Model> _list = [
    Model(id: "1", name: "name 1", title: "a title 1"),
    Model(id: "2", name: "name 2", title: "a title 2"),
    Model(id: "3", name: "name 3", title: "b title 3"),
    Model(id: "4", name: "name 4", title: "b title 4"),
    Model(id: "5", name: "name 5", title: "b title 5"),
  ];
  List<Model> _searchList = _list;

  bool _isSearching = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    init();
  }

  void init() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SearchController>();
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return GridItem(_searchList[index]);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            )));
  }

  List<Model> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList = _list;
    } else {
      _searchList = _list
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()) ||
              element.title.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList;
    }
  }

  PreferredSizeWidget buildBar(BuildContext context) {
    final controller = context.watch<SearchController>();

    return AppBar(
        centerTitle: true,
        title: controller.isSearching
            ? TextField(
                controller: _searchQuery,
                style: const TextStyle(
                  color: Colors.orange,
                ),
                decoration: const InputDecoration(
                    hintText: "Search here..",
                    hintStyle: TextStyle(color: Colors.white)),
              )
            : const Text(
                "Search Demo",
                style: TextStyle(color: Colors.white),
              ),
        iconTheme: const IconThemeData(color: Colors.orange),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              controller.isSearching ? Icons.close : Icons.search,
              color: Colors.orange,
            ),
            onPressed: () {
              if (controller.isSearching) _searchQuery.clear();
              context
                  .read<SearchController>()
                  .setSearching(!controller.isSearching);
            },
          ),
        ]);
  }
}

class GridItem extends StatelessWidget {
  final Model model;
  const GridItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 7),
      elevation: 10.0,
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          print(model.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.name,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 0.0),
                  Text(
                    model.title,
                    style: const TextStyle(fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
