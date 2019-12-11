package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.apptreesoftware.barcodescan.BarcodeScanPlugin;
import id.kakzaki.blue_thermal_printer.BlueThermalPrinterPlugin;
import com.mranuran.clipboardmanager.ClipboardManagerPlugin;
import io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin;
import io.flutter.plugins.firebaseauth.FirebaseAuthPlugin;
import io.flutter.plugins.firebase.core.FirebaseCorePlugin;
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;
import io.flutter.plugins.googlemaps.GoogleMapsPlugin;
import io.flutter.plugins.googlesignin.GoogleSignInPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.tekartik.sqflite.SqflitePlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    BarcodeScanPlugin.registerWith(registry.registrarFor("com.apptreesoftware.barcodescan.BarcodeScanPlugin"));
    BlueThermalPrinterPlugin.registerWith(registry.registrarFor("id.kakzaki.blue_thermal_printer.BlueThermalPrinterPlugin"));
    ClipboardManagerPlugin.registerWith(registry.registrarFor("com.mranuran.clipboardmanager.ClipboardManagerPlugin"));
    CloudFirestorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin"));
    FirebaseAuthPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebaseauth.FirebaseAuthPlugin"));
    FirebaseCorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.core.FirebaseCorePlugin"));
    FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
    FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
    GoogleMapsPlugin.registerWith(registry.registrarFor("io.flutter.plugins.googlemaps.GoogleMapsPlugin"));
    GoogleSignInPlugin.registerWith(registry.registrarFor("io.flutter.plugins.googlesignin.GoogleSignInPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
