# FlutterTube
This YouTube clone app is built using Flutter and Dart. It replicates key features of YouTube, providing a platform for users to view, upload, and comment on videos. The app leverages Firebase for authentication, storage, and real-time data updates.

### Features
1. User Authentication
Firebase Authentication: Users can sign up, log in, and log out using Firebase Authentication.
Google Sign-In: Integration with Google Sign-In for seamless user authentication.
2. Profile Management
Profile Picture Display: Shows the current user’s profile picture on the home page dynamically based on the logged-in user's email.
3. Video Management
Video Upload: Users can upload videos from their gallery using the image_picker package.
Video Playback: Videos are played using the video_player package.
FFmpeg for Video Editing: Utilizes ffmpeg_kit_flutter for video processing tasks.
4. Comments Section
Real-Time Comments: Displays comments for each video in real-time using Firestore.
Posting Comments: Users can post comments which are immediately updated in the database and UI.
First Comment Highlight: The first comment is displayed distinctly at the top, mimicking YouTube’s interface.
Timestamp Display: Comment timestamps are displayed in a human-readable format using the timeago package.
5. Suggested Videos
Recommended Videos: Displays a list of suggested videos related to the currently viewed video.
6. UI Components
Bottom Sheet for Actions: Uses showModalBottomSheet for displaying actions like sharing or reporting a video.
Default TabBarView: Implements tab-based navigation for different sections of the app.
### Technical Details
 - Setting Up Firebase
   - Firebase Integration: Add Firebase to your Flutter project via the Firebase Console.
   - Dependencies: Add firebase_core and cloud_firestore dependencies to pubspec.yaml.
 - Using Firestore Queries
    - First Comment Query: Fetch the first comment using Firestore's query capabilities, ordering by timestamp and limiting the result to one.
    - Remaining Comments Query: Fetch the rest of the comments, skipping the first document.
- Utilizing StreamBuilder
   - Real-Time Updates: Use StreamBuilder to listen to Firestore query snapshots for real-time UI updates.
   - First Comment StreamBuilder: Create a StreamBuilder to display the first comment separately.
   - Remaining Comments StreamBuilder: Use another StreamBuilder to display the remaining comments.
- Video Upload and Playback
  - ImagePicker for Video Selection: Use the image_picker package to allow users to pick videos from their gallery.
  - Video Playback: Play videos using the video_player package.
  - File Handling: Convert XFile to File for compatibility with video player and storage.
- Formatting Timestamps
  - timeago Package: Use the timeago package to display comment timestamps in a human-readable format like "5 minutes ago".
- Detailed Implementation of Comments Section
  - Firestore Queries: Query Firestore to fetch the first comment and the remaining comments separately.
  - StreamBuilder for Real-Time Updates: Use StreamBuilder to listen to Firestore snapshots and update the UI in real-time.
  - Distinct Display of First Comment: Highlight the first comment by displaying it separately at the top.
  - Real-Time Comment Posting: Implement a comment form allowing users to post comments, updating Firestore and the UI in real-time.
 
 
## Author

   ### Shantanu Khadse

   For any query, contribution, You can contact here,
  
  GitHub: [ShantanuKH](https://github.com/ShantanuKH)
  
  Email: shantanukhadse784@gmail.com  
  
  LinkedIn: [shantanukhadse](https://www.linkedin.com/in/shantanu-khadse-a62585230/)

