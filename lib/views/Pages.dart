import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todolist_lite/main.dart';
import 'package:todolist_lite/models/item.dart';
import 'package:todolist_lite/models/toDo.dart';
import 'package:todolist_lite/models/toDo_lookup.dart';
import 'package:todolist_lite/widgets/Widgets.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:todolist_lite/models/CategoryTask.dart';
import 'package:todolist_lite/models/StatusTask.dart';
import 'package:todolist_lite/models/item.dart';

import 'package:todolist_lite/services/Notification_service.dart';

import '../widgets/Widgets.dart';

import '../widgets/Widgets.dart';
import 'dart:ffi';
part 'Edit_Task_Page.dart';
part 'Task_Page.dart';
part 'Add_Task_Page.dart';
part 'Task_Notification.dart';
part 'Auth_Page.dart';
part 'Register_Page.dart';
part 'Logging_Page.dart';
part 'Login_Page.dart';
part 'Home.dart';
part 'Forgot_Password_Page.dart';
part 'Task_Detail_Page.dart';
part 'Search_Delegate.dart';
