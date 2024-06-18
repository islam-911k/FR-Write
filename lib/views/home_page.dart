import 'package:flutter/material.dart'; // Importing Flutter's material package for UI components.
import 'package:get/get.dart'; // Importing GetX package for state management and reactive programming.
import 'package:write_fr/controller/speech_controller.dart'; // Importing the SpeechController from the specified path.



class HomePage extends StatelessWidget { // Defining a stateless widget for the home page.
  const HomePage({super.key}); // Constructor for HomePage with a key parameter.

  @override
  Widget build(BuildContext context) { // Overriding the build method to describe the part of the UI represented by this widget.
    final SpeechController speechController = Get.put(SpeechController()); // Initializing and registering SpeechController using GetX for dependency injection and state management.

    return Scaffold( // Creating a scaffold to provide structure to the app's UI.
      appBar: AppBar(
        title: const Text("FR-Writing Practice"), // Setting the title of the app bar.
        centerTitle: true, // Centering the title.
        backgroundColor: Colors.deepPurple, // Setting the background color of the app bar.
        elevation: 0, // Removing the shadow under the app bar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding of 16 pixels around the body content.
        child: Column( // Creating a column layout to arrange child widgets vertically.
          mainAxisAlignment: MainAxisAlignment.center, // Centering the children vertically within the column.
          children: [
            const SizedBox(
              height: 20, // Adding vertical spacing of 20 pixels.
            ),
            Obx(() => Text( // Using Obx to make the Text widget reactive to changes in recognizedWord.
              speechController.recognizedWord.value.isEmpty
                  ? "Your word" // Placeholder text if no word has been recognized yet.
                  : speechController.recognizedWord.value, // Displaying the recognized word.
              style: const TextStyle(
                fontSize: 30, // Setting the font size of the displayed text.
                fontWeight: FontWeight.bold, // Making the text bold.
                color: Colors.deepPurple, // Setting the text color.
              ),
              textAlign: TextAlign.center, // Centering the text.
            )),
            const SizedBox(
              height: 20, // Adding vertical spacing of 20 pixels.
            ),
            TextField(
              onChanged: speechController.checkWord, // Calling the checkWord method each time the text field's content changes.
              decoration: InputDecoration(
                hintText: "Type the word here", // Hint text displayed inside the text field.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Making the border rounded.
                  borderSide: const BorderSide(
                    color: Colors.deepPurple, // Setting the border color.
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Making the border rounded when focused.
                  borderSide: const BorderSide(
                    color: Colors.deepPurple, // Setting the border color when focused.
                    width: 2.0, // Increasing the border width when focused.
                  ),
                ),
                prefixIcon: const Icon(Icons.edit, color: Colors.deepPurple), // Adding an icon inside the text field.
              ),
            ),
            const SizedBox(
              height: 20, // Adding vertical spacing of 20 pixels.
            ),
            Obx(() { // Using Obx to make this part of the UI reactive to changes in isCorrect.
              if (speechController.isCorrect.value != null) { // Checking if isCorrect has a non-null value.
                return Text(
                  speechController.isCorrect.value! ? "Correct!" : "Try Again!", // Displaying "Correct!" or "Try Again!" based on the value of isCorrect.
                  style: TextStyle(
                    fontSize: 24, // Setting the font size of the feedback text.
                    fontWeight: FontWeight.bold, // Making the feedback text bold.
                    color: speechController.isCorrect.value! ? Colors.green : Colors.red, // Setting the text color to green if correct, red otherwise.
                  ),
                );
              }
              return const SizedBox(); // Returning an empty SizedBox if isCorrect is null, i.e., no feedback to display yet.
            }),
            const SizedBox(
              height: 20, // Adding vertical spacing of 20 pixels.
            ),
            Obx(() { // Using Obx to make this part of the UI reactive to changes in isListening.
              return Column(
                children: [
                  Text(
                    speechController.isListening.value ? "Listening..." : "Press the button to start listening", // Displaying "Listening..." when the app is actively listening.
                    style: const TextStyle(fontSize: 18, color: Colors.grey), // Setting the font size and color of the status text.
                  ),
                  const SizedBox(
                    height: 20, // Adding vertical spacing of 20 pixels.
                  ),
                  FloatingActionButton(
                    onPressed: speechController.startListening, // Calling startListening method when button is pressed.
                    backgroundColor: Colors.deepPurple, // Setting the background color of the button.
                    child: Icon(
                      speechController.isListening.value ? Icons.mic : Icons.mic_none, // Changing icon based on listening state.
                      color: speechController.isListening.value ? Colors.red : Colors.white, // Changing icon color based on listening state.
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
