# TutorGroup
Tutor Group: Is an online explore tutoring is an app which enables students and tutors to interact, 
where tutors have their special accounts and student as regular accounts, this makes easier for students 
and tutors to adjust the demanded session (dealing).

### for implementing the final solo project as WeCode required procedure 


## services uses:
* firebase authentication both PhoneNumber & emailAndPassword.
* Firebase Firestore containing two collections(Teachers & Users as students )
* Firebase CloudStorage storing image files
* Get_Storage as a local storage for storing some important variables such as used for (isDarkmode or LightMode )
* Provider State management and user saving his information and sharing in entire application.
* timeago package ( messages are sent in between user and teacher in a format which also saves the time the message sent which saves the Server Time instead of using device time, However reciever shoing message in an format of ( a momment ago , 10 minutes ago or 10 days ago .....etc).
* CacheNetworkImage and CachedNetworkImageProvider used to cache the images in a local memory of device.
* The teacher differintiate between Males & Females by their Image which automatically selected when the student selects their gender in SignUp form, Their profile pictures are not stored in Firebase_storage in order of the size of files in it would be enourmous for a not needed purposes instead of the teacher images they are stored in FirebaseStorage.
* Custom Loading used 




## The Logic

### Teachers:
* can not sign up unless the admin can sign him up in another special application(TutorAdmin).
* use's their email & password where they given to him by Tutor Admin and signed him to the system.
* not able to explore students unless he got a message from him before.
* the ability of exploring other teachers without connecting to them.


### Students:
* can sign up once and then sign in with his provided info. before.
* uses their Phone Number to sign in & sign up with necessary informations.
* not able to explore or interact with any other student.
* the ability to explore teachers and interact with them.
![Screenshot_1662996885](https://user-images.githubusercontent.com/97254019/190927735-0398b50b-fa6a-4b74-9379-aba3a91746fb.png)
![Screenshot_1663175859](https://user-images.githubusercontent.com/97254019/190927743-e1df7aa4-c9a6-49cf-9709-dddb341ea7a9.png)



## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

<p align="center"><img src="https://user-images.githubusercontent.com/97254019/190927735-0398b50b-fa6a-4b74-9379-aba3a91746fb.png" width=150 height=150></p>
<p align="center"><img src="https://user-images.githubusercontent.com/97254019/190927743-e1df7aa4-c9a6-49cf-9709-dddb341ea7a9.png" width=150 height=150></p>
# packages used:
```dart
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  lottie: ^1.3.0
  flutter_svg: ^1.1.1+1
  get: ^4.6.5
  get_storage: ^2.0.3
  http: ^0.13.4
  font_awesome_flutter: ^10.1.0
  pinput: ^2.2.11
  firebase_core: ^1.20.0
  cloud_firestore: ^3.4.2
  firebase_auth: ^3.6.3
  device_preview: ^1.1.0
  country_pickers: ^2.0.0
  provider: ^6.0.3
  cached_network_image: ^3.2.1
  flutter_screenutil: ^1.0.2
  blurrycontainer: ^1.0.2
  background_app_bar: ^2.0.1
  nil: ^1.1.1
  entry: ^0.0.7
  auto_size_text: ^3.0.0
  chat_bubbles: ^1.3.1
  shimmer: ^2.0.0
  timeago: ^3.3.0
  url_launcher: ^6.1.5
  google_fonts: ^3.0.1
  flutter_spinkit: ^5.1.0
  
  
  dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  rename: ^2.0.1
  flutter_launcher_icons:
  flutter_native_splash:
flutter_icons:
  image_path: "assets/images/tutorlogo.png"
  adaptive_icon_foreground: "assets/images/tutor_logo_foreground.png"
  adaptive_icon_background: "#ffffff"
  android: true
flutter_native_splash:
  color: "#140C34"
  image: "assets/images/tutorlogo.png"
  web: false
```
<p align="center"><img src="https://user-images.githubusercontent.com/97254019/179369890-28d9d041-e9ba-4e73-bfba-e0512c31b4c5.png" width=150 height=150></p>
