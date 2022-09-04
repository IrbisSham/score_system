import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {

  Future<bool> isIpad() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.name!.toLowerCase().contains("ipad")) {
      return true;
    }
    return false;
  }

}

