// colors
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const main_color = Color(0xFF66dbfd);
const color_grid = [Color(0xFF66dbfd), Color(0xFF058aed)];
const color_dark_theme=Color(0xFF1f9ef1);

ShowPermission(){
  showPermissiondialog(BuildContext context) async {
    // You can request multiple permissions at once.
    if (await Permission.camera.request() == false ||
        Permission.location.request().isGranted == false) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.camera,
        Permission.storage,
      ].request();
    }
  }

}