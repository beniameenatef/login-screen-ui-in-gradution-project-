import 'package:design_ui/modules/Drawer/drawer.dart';
import 'package:design_ui/modules/TapAppBar/tabbarmenu.dart';
import 'package:design_ui/modules/datialesHomeScreen/detailshome.dart';
import 'package:design_ui/network/http/http2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/modelMaktba.dart';
import '../../models/yearsmodel.dart';
class Almaktba extends StatefulWidget {
  Almaktba({Key? key}) : super(key: key);

  @override
  home createState() => home();
}

class home extends State<Almaktba> {
  TextEditingController edit =TextEditingController();

  // late Future<Year> year;
  late Future<Library> library;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    library = GetLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Color(0xFF054978),
          leadingWidth: 35,
          leading:
          IconButton(onPressed: ()
          {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) =>  AppDrawer(child:detailshomePage()),
              ),
            );
          },icon: Icon(Icons.arrow_back_ios,color: Color(0xFFF1770D),),
          ),
          titleSpacing: 0,

          title:const Text('المكتبة',style: TextStyle(fontWeight: FontWeight.bold,
              color: Color(0xFFF1770D)),),
          actions: [
            InkWell(
              onTap: ()
              {

              },
              child: Column(children: [
                Icon(Icons.edit),
                Text('Edit'),

              ],),
            )
          ],
        ),
        body: FutureBuilder<Library>(
          future: library,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<?>? Yearinfo = snapshot.data!.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      SizedBox(
                        height: 20,
                      ),
                      DataTable(
                        columnSpacing: 38.0,
                        columns: const [
                          DataColumn(label: Text('Year')),
                          DataColumn(label: Text('Book Type')),
                          DataColumn(label: Text('Number')),
                        ],
                        rows:
                            List.generate(snapshot.data!.data!.length, (index) {
                          final y = snapshot.data!.data![index].attributes!
                              .academicYear!.data!.attributes!.year
                              .toString();
                          final x = snapshot.data!.data![index].attributes!
                              .bookType!.data!.attributes!
                              .toString();
                          final z =
                              snapshot.data!.data![index].attributes!.number;

                          return DataRow(cells: [
                            DataCell(Container(width: 75, child: TextFormField(controller:edit  ,
                                keyboardType:TextInputType.name ,
                                decoration: InputDecoration(hintText:"${y}" ),
                                )
                            )
                            ),
                            DataCell(Container(child: Text('${x}'))),
                            DataCell(Container(child: Text('${z}')))
                          ]);
                        }),
                      ),
                    ],

                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

                    CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    Text('LOADING'),
                  ],
                ),
              );
            }
          },
        ));
  }
}
