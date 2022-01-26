import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/customs/icon_broken.dart';
import 'package:social_app/models/chat_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/network/cache_helper.dart';
import 'package:social_app/screens/another_user_screen.dart';
import 'package:social_app/screens/home_page_screen.dart';
import 'package:social_app/screens/setting_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../constans.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  bool darkMode = false;
  void changeAppMode({bool? fromShare}){
    if(fromShare!= null){
      darkMode = fromShare;
    }
    else darkMode = !darkMode;
    CacheHelper.saveData(key: "lightMode", value: darkMode).then((value) {
      emit(ChangeAppMode());
    });

  }

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.Home,
        ),
        label: "Home"),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: "Chat"),
    // BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: "Users"),
    BottomNavigationBarItem(icon: Icon(IconBroken.Profile), label: "Profile"),
  ];
  List<Widget> screens = [
    HomePageScreen(),
    AnotherUserScreen(),
    // FeedsScreen(),
    ProfileScreen(),
  ];
  List<String> title = ["Home", "Chat", "Profile"];

  void ChangeBottomNav(int index) {
    if (index == 1){
      getAllUser();
    }
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  UserModel? userModel;
  void getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState());
    });
  }

  File? profileImage;
  File? coverImage;
  File? postImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      uploadProfileImage();
    } else {
      print("No image selected");
      emit(ProfileImagePickerErrorState());
    }
  }

  void uploadProfileImage() {
    emit(ProfileImageLoadingUpdateState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateUserData(profileImage: value);
      }).catchError((error) {
        ProfileImageUpdateErrorState();
      });
      print(value);
    }).catchError((error) {
      ProfileImageUpdateErrorState();
    });
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      uploadCoverImage();
    } else {
      print("No image selected");
      emit(CoverImagePickerErrorState());
    }
  }

  void uploadCoverImage() {
    emit(CoverImageLoadingUpdateState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateUserData(coverImage: value);
      }).catchError((error) {
        CoverImageUpdateErrorState();
      });
      print(value);
    }).catchError((error) {
      CoverImageUpdateErrorState();
    });
  }

  void UpdateUserData({
    String? userName,
    String? phone,
    String? bio,
    String? coverImage,
    String? profileImage,
  }) {
    userModel = UserModel(
        name: userName ?? userModel!.name,
        phone: phone ?? userModel!.phone,
        email: userModel!.email,
        userID: userModel!.userID,
        bio: bio ?? userModel!.bio,
        cover: coverImage ?? userModel!.cover,
        profile: profileImage ?? userModel!.profile);
    emit(LoadingUpdateUserDataState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.userID)
        .update(userModel!.toMap())
        .then((value) {
      getUser();
//    PostCubit().getUser();
      emit(UpdateUserDataStateSuccess());
    }).catchError((error) {
      emit(UpdateUserDataStateError());
    });
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
//      uploadPostImage();
      emit(PostImageSuccessState());
    } else {
      print("No image selected");
      emit(PostImageErrorState());
    }
  }

  void uploadPostImage({
    String? postText,
    String? dateTime,
  }) {
    emit(LoadingPostState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(postImage: value, postText: postText, dateTime: dateTime);
        emit(PostSuccessState());
      }).catchError((error) {
        emit(PostErrorState());
      });
      print(value);
    }).catchError((error) {
      emit(PostErrorState());
    });
  }

  PostModel? postModel;

  void createPost({
    String? postText,
    String? postImage,
    String? dateTime,
  }) {
    postModel = PostModel(
        name: userModel!.name,
        postImage: postImage ?? "",
        postText: postText,
        userID: userModel!.userID,
        profile: userModel!.profile,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel!.toMap())
        .then((value) {
      getPosts();
      getComments();
      getLikes();
      emit(PostSuccessState());
    }).catchError((error) {
      emit(PostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];

  Map<String, bool>? getLike = {};
  Map<String, List<Map<String, String>>>? getComment = {};

  void getComments() {
    // getComment!.clear();
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        String postId = element.id;
        element.reference.collection("comment").get().then((value) {
          value.docs.forEach((element) {
            getComment!.addAll({
              postId: [
                {"comment": element.data()["comment"], "user": element.id}
              ]
            });
//            print(getComment!["DfLIIVgYLqFuizYxwqty"]);
//            print(element.data()["comment"]);
          });
        }).catchError((error) {});
      });
      emit(GetCommentSuccessState());
    }).catchError((error) {
      emit(GetLikesErrorState());
    });
  }

  void getLikes() {
   // getLike!.clear();
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        String postId = element.id;
        element.reference
            .collection('likes')
            .doc(uId)
            .get()
            .then((value) {
          getLike!.addAll({postId: value.data()!['like']});
          print(getLike);
          emit(GetLikesSuccessState());
        }).catchError((error) {});
//        print(element.id);
//        print(element.data()["likePost"]);
        emit(GetLikesSuccessState());
      });
    }).catchError((error) {
      emit(GetLikesErrorState());
    });
  }

  void getPosts() {
    posts.clear();
    postId.clear();
    emit(LoadingGetPostsState());
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        getLikes();
        getComments();
        posts.add(PostModel.fromJson(element.data()));
        postId.add(element.id);
        emit(GetPostsSuccessState());
      });
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  void disLikePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection('likes')
        .doc(userModel!.userID)
        .set({'like': false}).then((value) {
      getLikes();
      emit(DisLikesSuccessState());
    }).catchError((error) {
      emit(DisLikesErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection('likes')
        .doc(userModel!.userID)
        .set({'like': true}).then((value) {
      getLikes();
      emit(LikesSuccessState());
    }).catchError((error) {
      emit(LikesErrorState());
    });
  }

  void writeComment(String postId, String commentText) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection('comment')
        .doc(userModel!.name)
        .set({"comment": commentText}).then((value) {
      getComments();
//      getPosts();
//      getLikes();
      emit(CommentSuccessState());
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  List<UserModel>? anotherUsers = [];
  void getAllUser() {
    anotherUsers!.clear();
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['userID'] != userModel!.userID) {
          // anotherUsers!.clear();
          anotherUsers!.add(UserModel.fromJson(element.data()));
          print(element.data());
        }
      });
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      emit(GetAllUserErrorState());
    });
  }

  void sendMessages(
      {required String text,
      required String dateTime,
      required String reciverId}) {
    MessageModel messageModel = MessageModel(
        text: text,
        senderId: userModel!.userID,
        dateTime: dateTime,
        reciverId: reciverId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel>? messages = [];

  void reciveMessages({required String reciverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages!.clear();
      event.docs.forEach((element) {
        messages!.add(MessageModel.fromJson(element.data()));
        emit(ReciveMessageSuccessState());
      });
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  void ShowPassword() {
    isPassword = !isPassword;
    if (isPassword) {
      suffixIcon = Icons.visibility_off_outlined;
    } else {
      suffixIcon = Icons.visibility_outlined;
    }
    emit(ChangePasswordVisibilityState());
  }

  void UserLogin({required String email, required String password}) {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      uId = value.user!.uid;
      getUser();
      getLikes();
      getPosts();
      getComments();
      getAllUser();
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error: error.toString()));
    });
  }

  void UserRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UserCreate(
          name: name, email: email, userID: value.user!.uid, phone: phone);
      print(value.user!.email);
      uId = value.user!.uid;
      getLike!.clear();
      getUser();
      getLikes();
      getComments();
      getPosts();
      getAllUser();
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(RegisterErrorState(error: error.toString()));
    });
  }

  void UserCreate(
      {required String name,
      required String email,
      required String userID,
      required String phone}) {
    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        email: email,
        userID: userID,
        bio: "Write your Bio",
        cover:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnqTzPwSxyTwHm7ZQyeRwvWFltxxbRTqIuKmLzxOXDnhcb1XE9a7GzE2Y_XO3kBBFmiFk&usqp=CAU",
        profile:
            "https://www.pngfind.com/pngs/m/110-1102775_download-empty-profile-hd-png-download.png");
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .set(userModel.toMap())
        .then((value) {
      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState(error: error));
    });
  }

  void SignOut() {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(
        key: "uId",
      ).then((value) {
        getLike!.clear();
        uId = "";
        emit(SignOutSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(SignOutErrorState());
    });
  }
}
