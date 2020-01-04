import 'package:flutter/material.dart';
import 'package:flutter_app/model/size_config.dart';
import 'package:flutter_app/model/video.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:flutter_app/api.dart';

class Newsletter extends StatefulWidget {
  Newsletter({Key key}) : super(key: key);
 
  @override
  _NewsletterState createState() => _NewsletterState();
}
 
class _NewsletterState extends State<Newsletter> {

  _listVideos(){

    Api api = Api();
    return api.search("");

  }

  Widget _searchButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.search),
        backgroundColor: Color(0xff38c4d8),
        foregroundColor: Colors.black87,
        splashColor: Colors.black87,
        tooltip: "Buscar vídeos",
        onPressed: (){
          //showSearch(context: context, delegate: )
        },
      ),
    );
  }

  Widget _news(){
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black54, Colors.grey],
            )
          ),
          alignment: Alignment.topCenter,
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: FutureBuilder<List<Video>>(
            future: _listVideos(),
            builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff38c4d8),
                    ),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  if(snapshot.hasData){
                    return ListView.separated(
                      itemBuilder: (context, index){
                        List<Video> _videos = snapshot.data;
                        Video _video = _videos[index];
                        return Column(
                          children: <Widget>[
                            Container(
                              height: SizeConfig.blockSizeVertical*27,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_video.image)
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(_video.title,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(_video.channel),
                            
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Divider(height: SizeConfig.blockSizeVertical*2.5, color: Colors.white),
                      itemCount: snapshot.data.length,
                    );
                  }
                  else{
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  break;
              }
            },
          ),
        ),
        _searchButton(),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return _news();
  }
}