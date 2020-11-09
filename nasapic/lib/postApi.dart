// import 'package:json_annotation/json_annotation.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart';

// part 'post_api.g.dart';

// @RestApi(
//     baseUrl:
//         "https://api.nasa.gov/planetary/apod?date=$date&hd=true&api_key=DEMO_KEY")
// abstract class RestClient {
//   factory RestClient(Dio dio) = _RestClient;
//   @GET("/date")
//   Future<List<Post>> getTasks();
// }

// @JsonSerializable()
// class Post {
//   String imgUrl;
//   String imgInfo = "Image Information";
//   String imgTitle = 'Image Title';
//   String fileType = "fileType";
//   String year;
//   String month;
//   String day;

//   Post(
//       {this.imgUrl,
//       this.imgInfo,
//       this.imgTitle,
//       this.fileType,
//       this.year,
//       this.month,
//       this.day});

//   factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
//   Map<String, dynamic> toJson() => _$PostToJson(this);
// }
