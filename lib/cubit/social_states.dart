abstract class SocialStates {}
class SocialInitialState extends SocialStates {}
class ChangeBottomNavBar extends SocialStates{}
class ChangeAppMode extends SocialStates{}

class GetUserLoadingState extends SocialStates{}
class GetUserSuccessState extends SocialStates{}
class GetUserErrorState extends SocialStates{}
class ProfileImagePickerSuccessState extends SocialStates{}
class ProfileImagePickerErrorState extends SocialStates{}
class ProfileImageLoadingUpdateState extends SocialStates{}
class ProfileImageUpdateSuccessState extends SocialStates{}
class ProfileImageUpdateErrorState extends SocialStates{}

class CoverImagePickerSuccessState extends SocialStates{}
class CoverImagePickerErrorState extends SocialStates{}
class CoverImageLoadingUpdateState extends SocialStates{}
class CoverImageUpdateSuccessState extends SocialStates{}
class CoverImageUpdateErrorState extends SocialStates{}

class LoadingUpdateUserDataState extends SocialStates{}
class UpdateUserDataStateSuccess extends SocialStates{}
class UpdateUserDataStateError extends SocialStates{}


class PostImageSuccessState extends SocialStates {}
class PostImageErrorState extends SocialStates {}
class LoadingPostState extends SocialStates{}
class PostSuccessState extends SocialStates{}
class PostErrorState extends SocialStates{}
class LoadingGetUserState extends SocialStates{}
class LoadingGetPostsState extends SocialStates{}
class GetPostsSuccessState extends SocialStates{}
class GetPostsErrorState extends SocialStates{}
class GetLikesSuccessState extends SocialStates{}
class GetLikesErrorState extends SocialStates{}
class LikesSuccessState extends SocialStates{}
class LikesErrorState extends SocialStates{}
class DisLikesSuccessState extends SocialStates{}
class DisLikesErrorState extends SocialStates{}
class CommentSuccessState extends SocialStates{}
class CommentErrorState extends SocialStates{}
class GetCommentSuccessState extends SocialStates{}
class GetCommentErrorState extends SocialStates{}


class GetAllUserSuccessState extends SocialStates{}
class GetAllUserErrorState extends SocialStates{}
class SendMessageSuccessState extends SocialStates{}
class SendMessageErrorState extends SocialStates{}
class ReciveMessageSuccessState extends SocialStates{}


class RegisterInitialState extends SocialStates {}

class ChangePasswordVisibilityState extends SocialStates {}

class LoginInitialState extends SocialStates {}

class LoadingLoginState extends SocialStates {}

class LoginSuccessState extends SocialStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends SocialStates {
  final String error;
  LoginErrorState({required this.error});
}

class LoadingRegisterState extends SocialStates {}

class RegisterSuccessState extends SocialStates {
  final String uId;

  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends SocialStates {
  final String error;
  RegisterErrorState({required this.error});
}

class UserCreateSuccessState extends SocialStates {}

class UserCreateErrorState extends SocialStates {
  final String error;
  UserCreateErrorState({required this.error});
}


class SignOutSuccessState extends SocialStates {}
class SignOutErrorState extends SocialStates {}