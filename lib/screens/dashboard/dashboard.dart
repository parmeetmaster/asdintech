import 'package:asdintech/screens/dashboard/helper/dashboard_helper.dart';
import 'package:asdintech/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text("Background Verification App"),
      ),
      body: Stack(children: [
        Container(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120,
                color: Colors.grey[100],
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/pngs/asdlogo.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 30, bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Asdintech Pvt Ltd.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                                "Address : A – 43, Block A, Sector 57, Noida, Uttar Pradesh 201307"),
                            Text("phno: 0120 467 9450"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 130, left: 10, right: 10),
            child: GridView.builder(
              itemCount: DashBoardHelper.options.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      DashBoardHelper.perform_navigate(
                          DashBoardHelper.options[index], context);
                    },
                    child: DashBoardCard(
                      image: DashBoardHelper.images[index],
                      title: DashBoardHelper.options[index],
                    ));
              },
            ))
      ]),
    );
  }
}
