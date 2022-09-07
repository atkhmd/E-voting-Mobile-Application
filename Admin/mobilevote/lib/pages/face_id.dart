import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/Admin/home_admin.dart';
import 'package:mobilevote/api/local_auth_api.dart';

class FaceId extends StatefulWidget {
  const FaceId();

  @override
  _FaceIdState createState() => _FaceIdState();
}

class _FaceIdState extends State<FaceId> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          // ignore: deprecated_member_use
          brightness: Brightness.light,
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Face Id Auth",
                    style: GoogleFonts.robotoMono(
                        textStyle: Theme.of(context).textTheme.headline3,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                buildHeader(),
                const SizedBox(height: 32),
                buildAvailability(context),
                const SizedBox(height: 24),
                buildAuthenticate(context),
              ],
            ),
          ),
        ),
      );

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  buildText('Biometrics', isAvailable),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                )
              ],
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? const Icon(Icons.check, color: Colors.green, size: 24)
                : const Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeAdmin()),
            );
          }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

  Widget buildHeader() => Column(
        children: [
          const Text(
            'Face ID Auth',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) {
              final colors = [Colors.blueAccent, Colors.pink];

              return RadialGradient(colors: colors).createShader(bounds);
            },
            child: const Icon(Icons.face_retouching_natural,
                size: 100, color: Colors.white),
          ),
        ],
      );
}
