Flutter & Firebase Home Project: Weight Tracker

Implement a simple weight tracker app using Firebase Auth and Cloud Firestore.

On first launch, the app lets users sign in with Firebase (use anonymous sign-in for simplicity).

After sign in, the app shows a page where the user can:
-Enter his/her weight into a form and submit it
-Save this along with the current time into Firestore
-View a list of all weight entries, sorted by most recent date

The app should update in realtime when the data changes on Firestore.

Bonus features:
-Edit an existing weight entry
-Delete entries
-Sign-out functionality

Notes:
-feel free to use dependency injection libraries such as Provider or get_it if appropriate.
-when building the UI and navigating between screens, choose the approach that makes most sense in terms of usability.
-adding tests is not required for this project, but the final code should be testable.

If some requirements appear to be vague or lack sufficient details, make assumptions based on your own judgment.

The assignment will be evaluated according to the following criteria:
-the app works and satisfies the requirements outlined above
-general project structure and organization of code
-separation of concerns between UI, authentication, database code
-simplicity - we don't require an over-engineered solution
-naming conventions for variables, functions and classes

Making the UI look nice is not required as part of this task - legible text and usable UI is sufficient.