# mixNteach
mixNteach

What is mixNTeach?

mixNteach is an experience that aims to adopt a teacher's conventional pedagogical methods and turn it into a mobile phone based educational tool. 
teachTools’s objective are three folds: Curation, Creation and Conferring

### Curation
This enables our teachers/users to save learning materials on the go.
This part of our application serves to cumulate the content or learning materials in the midst of using other applications.
It makes curation easier by allowing the user to tag materials and create categories for easy access.
### Creation
This module is capable of creating lesson plan that orders material in sequence to deliver a particular concept in a classroom
Creating a lesson plan involves creating modules that allows the user to create a theme and append learning materials that were curated earlier 
### Conferring
This enables the user to teach over the lesson plans created or learning materials curated in the previous step. 
By “teach” we enable the users to record their sessions with video, audio or annotations over these  created learning modules.

## Developer Guide:
We have used the flutter framework for our development of mixNteach application. 
This part of the document aims for any developer to explain the whole structure of our project
Although Flutter aims to manage the frontend and backend models together for the sake of code maintenance we have tried to slice it in the following way:
1. Widgets
2. Backend Operations
3. DB interactions

### Main Script and Routes
1. (main.dart)[mixNteach/blob/main/lib/main.dart] is responsible for starting the application and getting things in order. 
2. (routes.dart)[mixNteach/blob/main/lib/routes.dart] is the routes directory of the app. Each page has a designated route and the controller of this particular page will be called in the backend.

### src directory
1. 




