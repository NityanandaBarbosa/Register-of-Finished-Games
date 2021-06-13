import 'package:flutter_modular/flutter_modular.dart';
import 'package:finished_games_register/app/modules/list/list_store.dart';
import 'package:finished_games_register/app/styles/gradient_containers.dart'
    as gradientComp;
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final String title;
  const ListPage({key, this.title = 'ListPage'}) : super(key: key);
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends ModularState<ListPage, ListStore> {
  final ListStore store = Modular.get<ListStore>();

  Future _onItemTapped(int index) async {
    setState(() {
      store.setIndex(index);
    });
    await store.getSelected();
  }

  @override
  Widget build(BuildContext context) {
    final fullMediaWidth = MediaQuery.of(context).size.width;
    final fullMediaHeight = MediaQuery.of(context).size.height;

    store.getCredential();

    Widget listComponents(context) {
      return Container(
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            /*Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('${store.selectedIndex}')
              ),*/
            store.crudLists(fullMediaWidth, fullMediaHeight),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: gradientComp.appBarGradient(context, "Finished Games"),
      body: gradientComp.backgroundGradient(context, listComponents(context)),
      bottomNavigationBar: gradientComp.containerGradient(
        context,
        BottomNavigationBar(
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          //ype: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Publisher',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Register',
            ),
          ],
          currentIndex: store.selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF13213b),
        onPressed: () async {
          await store.openCrud();
        },
        child: Icon(Icons.my_library_add),
      ),
    );
  }
}
