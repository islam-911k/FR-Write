import 'package:get/get.dart'; // Importing the GetX package for state management and other utilities.
import 'package:permission_handler/permission_handler.dart'; // Importing the permission_handler package to handle runtime permissions.
import 'package:speech_to_text/speech_to_text.dart' as stt; // Importing the speech_to_text package for speech recognition functionality with an alias 'stt'.

// Controller class for speech recognition, extending GetxController for state management.
class SpeechController extends GetxController {
  final stt.SpeechToText _speechToText = stt.SpeechToText(); // Creating an instance of SpeechToText for speech recognition.

  var recognizedWord = ''.obs; // Observable variable to hold the recognized word.
  var isCorrect = Rxn<bool>(); // Observable variable to hold the correctness status of the recognized word.
  var isListening = false.obs; // Observable variable to hold the listening status.

  // Method to start listening for speech input.
  Future<void> startListening() async {
    // Requesting microphone permission.
    var status = await Permission.microphone.request();

    // Checking if the permission is granted.
    if (status != PermissionStatus.granted) {
      // Showing a snackbar if permission is denied.
      Get.snackbar("Permission Denied", "Microphone permission is required");
      return; // Exiting the method if permission is denied.
    }

    // Initializing the speech recognition and setting up status and error callbacks.
    bool available = await _speechToText.initialize(
      onStatus: (status) {
        print('OnStatus $status'); // Callback for status changes.
        isListening.value = status == 'listening'; // Updating the listening status.
      },
      onError: (error) {
        print('OnError: $error'); // Callback for errors.
        isListening.value = false; // Updating the listening status on error.
      },
    );

    // Checking if speech recognition is available.
    if (available) {
      // Listening for speech input and updating the recognized word.
      _speechToText.listen(
        onResult: (result) {
          recognizedWord.value = result.recognizedWords; // Updating the recognized word.
        },
        localeId: 'fr_FR', // Setting the locale for speech recognition to French.
      );
    } else {
      // Showing a snackbar if speech recognition is not available.
      Get.snackbar("Error", "Speech recognition not available");
    }
  }

  // Method to check if the typed word matches the recognized word.
  void checkWord(String typedWord) {
    // Checking if there is a recognized word.
    if (recognizedWord.value.isNotEmpty) {
      // Comparing the typed word with the recognized word (case-insensitive).
      isCorrect.value = typedWord.trim().toLowerCase() == recognizedWord.value.toLowerCase();
    }
  }
}