import 'package:githubapp/allImport.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class FollowerList extends StatefulWidget {
  String loginname;
  String fullName;
  FollowerList({Key key,this.loginname,this.fullName}) : super(key : key);
  @override
  _FollowerListState createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  List<FollowDetails> _userDetails = [];



  Future<Null> getUserDetails() async {

    final response = await http.get('https://api.github.com/users/${widget.loginname}/followers');
    var jsonResponse = convert.jsonDecode(response.body);

    setState(() {
      for (Map user in jsonResponse) {
        _userDetails.add(FollowDetails.fromJson(user));
      }
    });
  }


  @override
  void initState() {
    if(widget.loginname!=null)
    {
      getUserDetails();
    }
    super.initState();
  }

  @override
  void dispose() {
    _userDetails.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: Text(widget.fullName),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(h/15),
            child: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                tabs: <Widget>[
                 Tab(text: "Followers",),
                 Tab(text: "Followers",),
                  //Followers,Following
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(
          children: [
           _userDetails.length!=0 ?  ListView.builder(
          itemCount: _userDetails.length,
          itemBuilder: (context, i) {

            return Padding(
              padding: EdgeInsets.only(top:h/120,bottom:h/65),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    //   border: Border.all(width:0.0),

                    boxShadow: [BoxShadow(
                        color: Colors.grey[300],
                        blurRadius:7.0,
                        offset: Offset(1,3)
                    ),]
                ),

                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        maxRadius: w/12,

                        backgroundImage: NetworkImage(_userDetails[i].url)

                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        newText(_userDetails[i].name, textStyleCustom(h/35, Colors.black,FontWeight.bold)),
                        SizedBox(height:5,),
                        Row(
                          children: <Widget>[
                            newText("ID : ",  textStyleCustom(h/40, Colors.black,FontWeight.normal)),
                            SizedBox(height: 20,),
                            newText(_userDetails[i].id.toString(), textStyleCustom(h/40, Colors.black,FontWeight.normal)),
                          ],
                        )
                      ],
                    ),

                  ),

                ),
              ),
            );

          },
        ) : Center(child: CircularProgressIndicator(),),
            Center(child: Text("No data found"))

          ],
        )
      ),
    );
  }
}
