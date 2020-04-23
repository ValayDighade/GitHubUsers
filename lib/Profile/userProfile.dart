
import 'package:githubapp/allImport.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



class userProfile extends StatefulWidget {
  String loginname;

  userProfile({Key key,this.loginname}) : super(key : key);
  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {

  List<ProfileDetails>de;
  String imgName='https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png';
  var data;
  Future<ProfileDetails> getUserDetails() async {

    final response = await http.get('https://api.github.com/users/${widget.loginname}');
    setState(() {
      var jsonResponse = convert.jsonDecode(response.body);

      data=jsonResponse;
      print(data);
    });

  }

  @override
  void initState() {
    print(widget.loginname);
    if(widget.loginname!=null)
      {
        getUserDetails().whenComplete((){
          print(de);
        });
      }

    super.initState();
  }

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { double h=MediaQuery.of(context).size.height;
  double w=MediaQuery.of(context).size.width;


  return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowerList(loginname:data['login'],fullName: data['name'],)));
            },
            icon: Icon(
              Icons.receipt,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.purple,
        title: Center(child: Text("Profile")),
      ),
      body: data!=null ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              SizedBox(height:10,),
              CircleAvatar(
                maxRadius: 50,
                backgroundImage: NetworkImage(data['avatar_url']!=null ? data['avatar_url'] : imgName),
              ),
              SizedBox(height:20,),
              newText(data['name']!=null ? data['name'] : "-", textStyleCustom(h/35, Colors.black, FontWeight.bold)),
              SizedBox(height:10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                      Icons.location_on
                  )   ,
                  newText(data['location'] !=null ? data['location'] : "-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                ],
              ),
              SizedBox(height:10,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        newText(data['followers']!=null ? data['followers'].toString() : "-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                        SizedBox(width:5,),
                        newText("Followers", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                      ],
                    ),
                    Container(width:2,
                        height:15,
                        color: Colors.black),
                    Row(
                      children: <Widget>[
                        newText(data['following']!=null ? data['following'].toString() : "-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                        SizedBox(width:5,),
                        newText("Following", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height:20,),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          newText("Bio", textStyleCustom(h/40, Colors.black, FontWeight.bold)),
                          SizedBox(height:5,),
                          newText(data['bio']!=null ? data['bio'] : "-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                        ],
                      ),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          newText("Public repostiories", textStyleCustom(h/40, Colors.black, FontWeight.bold)),
                          SizedBox(height:5,),
                          newText(data['public_repos']!=null ? data['public_repos'].toString() : "-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                        ],
                      ),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          newText("Public gits", textStyleCustom(h/40, Colors.black, FontWeight.bold)),
                          SizedBox(height:5,),
                          newText(data['public_gists']!=null ? data['public_gists'].toString() :"-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                        ],
                      ),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          newText("Updated at", textStyleCustom(h/40, Colors.black, FontWeight.bold)),
                          SizedBox(height:5,),
                          newText(data['updated_at']!=null ? data['updated_at'].toString() : "-", textStyleCustom(h/45, Colors.black, FontWeight.normal)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }



}

class ProfileDetails {
  int id;
  String name;
  String url;


  ProfileDetails({
    this.id,
    this.name,
    this.url
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json)
  {
    return ProfileDetails(
      id: json['id'],
      name: json["login"],
      url: json["avatar_url"],

    );
  }


}