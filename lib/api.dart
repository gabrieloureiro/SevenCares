import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/video.dart';
const YOUTUBE_KEY_API = "AIzaSyDDf9LXYhdgkXQSkGSOfC2zG5j0L35OzBg";
const ID_CHANNEL = "UCPlemwX82_QEWRDC6yYnOCg";
const URL1 = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> search(String srch) async {

    http.Response response = await http.get(URL1 + "search" 
      "?part=snippet"
      "&type=video"
      "&maxResults=50"
      "&publishedAfter=2017-01-01T00:00:00Z"
      "&key=$YOUTUBE_KEY_API"
      "&channelId=$ID_CHANNEL"
      "&q=$srch"
    );

    if(response.statusCode == 200){

      Map<String, dynamic> dataJson = json.decode(response.body);
      
      List<Video> videos = dataJson["items"].map<Video>(
        (map){
          return Video.fromJson(map);
        }
      ).toList();

      return videos;

    }
    else {

    }
  }
}