import 'package:githubapp/allImport.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class AllGitUser extends StatefulWidget {

  @override
  _AllGitUserState createState() => new _AllGitUserState();
}

class _AllGitUserState extends State<AllGitUser> {
  TextEditingController controller = new TextEditingController();

  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];

  Future<Null> getUserDetails() async {

    final response = await http.get('https://api.github.com/users');
    var jsonResponse = convert.jsonDecode(response.body);

    setState(() {
      for (Map user in jsonResponse) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    getUserDetails();
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

    return SafeArea(
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(child: Text("GitHub")),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(h/10),
            child:  Container(

              color: Colors.purple,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10) ,
                    boxShadow: [BoxShadow(
                        color: Colors.grey[300],
                        blurRadius:1.0,
                        offset: Offset(1,2)
                    ),],
                    color: Colors.white,
                  ),
                  // color: Colors.white,
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextFormField(


                      controller: controller,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel, color: Colors.black,), onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),

          ),
        ),

        body:Homework( h/12),
      ),
    );
  }


  Homework(detailedScreenHeight)
  {

    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    TextStyle textStyle=new TextStyle(fontSize: h/55,fontFamily:'Nunito',color: Colors.black45);
    return   Column(
      children: <Widget>[

        new Expanded(
          child: _searchResult.length != 0 || controller.text.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.only(top:10.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                            maxRadius: w/12,

                            backgroundImage: NetworkImage(_searchResult[i].url)

                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            newText(_searchResult[i].name, textStyleCustom(h/35, Colors.black,FontWeight.bold)),
                            Row(
                              children: <Widget>[
                                newText("ID : ",  textStyleCustom(h/40, Colors.black,FontWeight.normal)),
                                SizedBox(height: 20,),
                                newText(_searchResult[i].id.toString(), textStyleCustom(h/40, Colors.black,FontWeight.normal)),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>userProfile(loginname: _searchResult[i].name,)));
                          },
                          icon: Icon(
                            Icons.arrow_right,
                            size: h/15,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(10.0),
            child: new ListView.builder(
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
                                newText("ID : ",  textStyleCustom(h/45, Colors.black,FontWeight.normal)),
                                SizedBox(height: 20,),
                                newText(_userDetails[i].id.toString(), textStyleCustom(h/45, Colors.black,FontWeight.normal)),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>userProfile(loginname: _userDetails[i].name,)));
                          },
                          icon: Icon(
                              Icons.arrow_right,
                            size: h/15,
                          ),
                        ),
                      ),


                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(_userDetails[i].id.toString(),style: TextStyle(fontSize: h/38,fontFamily: "Nunito"),),

                              Padding(
                                padding:  EdgeInsets.only(top:h/100),
                                child: Text('${"Topic :"}${" "}${_userDetails[i].name}',style: textStyle,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:6.0),
                                child: Text('${"Date of Assignment :"}${" "}${_userDetails[i].url}',style: textStyle,),
                              ),
                            ],
                          ),

                        ],
                      )*/
                    ),
                  ),
                );

              },
            ),
          ),
        ),
      ],
    );
  }


  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text) || userDetail.id.toString().toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }


}





