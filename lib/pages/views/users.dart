import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Constant.userList.isEmpty
          ? Center(
              child: Text(
                'No user!',
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          : Center(
              child: GridView.builder(
                controller: Controller.scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 600 ? 4 : 2,
                  childAspectRatio: 2,
                ),
                itemCount: Constant.userList.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 2.5,
                      child: ListTile(
                        // contentPadding: EdgeInsetsGeometry.infinity,
                        // visualDensity:
                        //     VisualDensity.adaptivePlatformDensity,
                        title: Text(
                          Constant.userList[index].fullName,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          Constant.userList[index].fullName,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        leading: Image.asset(
                            'assets/images/placeholder_user_00.jpg'),
                        onTap: null,
                        trailing: IconButton(
                          icon: Icon(Icons.delete_forever_outlined),
                          onPressed: () => setState(() {
                            Constant.userList.removeAt(index);
                          }),
                        ),
                      ));
                },
              ),
            ),
    );
  }
}
