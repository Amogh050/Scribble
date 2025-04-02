# Scribble

## Project Description
Scribble is a fun and interactive multiplayer drawing and guessing game where players take turns drawing an assigned word while others try to guess it. Compete with friends in a fast-paced game that challenges your creativity and word-guessing skills!

## Screenshots
<div align="center">
  <img src="https://github.com/user-attachments/assets/ad771d5b-38c7-4c32-a8c7-67f10f818ced" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/97196193-ca8a-47e3-8d93-bf0b500ff416" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/9369bb61-7f43-4f1c-8c7e-b439c8576b11" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
</div>
<div align="center">
  <img src="https://github.com/user-attachments/assets/314a9245-6a4f-4ad5-a56d-7ac5af7d2a37" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/8714749b-8349-44ce-9bbe-19e6b281918f" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/506f0277-61a9-449a-bef4-06e45b5955c0" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
</div>
<div align="center">
  <img src="https://github.com/user-attachments/assets/a1edb8b4-6d26-41ad-aac1-e88135d1887d" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/6b381ff2-cdde-4bdf-9b0c-6eb5e6b5ed3f" width="250px" height="450px" style="object-fit: cover; margin: 5px;" />
</div>

## Hosted URL
Download the latest APK and start playing! 🎮  

<a href="http://bit.ly/4hLVMaj" target="_blank">
  <img src="https://github.com/user-attachments/assets/10070ed8-a6f2-4fe2-89d5-01797d5b1260" alt="Download APK" width="200"/>
</a>  

🔽 **Click Below to Download** 🔽  
[📥 Download APK](http://bit.ly/4hLVMaj)  

## Demo Video
[![Scribble Demo](https://img.youtube.com/vi/-l84KezWrF0/1.jpg)](https://youtu.be/-l84KezWrF0)  

## Features Implemented

### Frontend
* **Interactive Drawing Canvas:** A flexible drawing board with color palette and eraser tools
* **Real-Time Rendering:** Seamless display of drawings as they are created
* **Live Chat Interface:** Interactive chat system for guessing words
* **Timer Display:** Visual countdown for each drawing round
* **Dynamic Leaderboard:** Real-time score updates
* **Room Creation & Joining:** Interface for creating and joining game rooms

### Backend
* **Real-Time Communication:** Socket.io implementation for instant data transmission
* **Game Logic Management:** Word selection, turn rotation, and scoring algorithms
* **Room Management System:** Creation, deletion, and management of game rooms
* **Database Integration:** Storage and retrieval of game data

## Technologies/Libraries/Packages Used
* **Flutter:** Frontend framework for cross-platform mobile application
* **Dart:** Programming language for Flutter application
* **Node.js & Express:** Backend framework for handling server-side operations
* **Socket.io:** Real-time bidirectional event-based communication
* **MongoDB:** NoSQL database for data storage
* **Mongoose:** MongoDB object modeling for Node.js
* **Flutter Canvas:** For drawing functionality
* **Flutter_colorpicker:** For color palette implementation

## Thought Behind the Project
Scribble was designed to bring people together through creativity and fun. In today's digital world, we wanted to create an engaging multiplayer experience that combines artistic expression with word games. The project aims to provide a simple yet addictive gameplay experience that can be enjoyed by players of all ages. The real-time nature of the game promotes quick thinking and creativity, while the social aspect encourages friendly competition and interaction.

## Local Setup

### Prerequisites
### Steps to Setup Locally

1. **Clone the Repository**
   ```sh
   git clone https://github.com/ajax-39/Scribble.git
   cd Scribble
   ```

2. **Install Dependencies**
   - **Frontend**:
     ```sh
     flutter pub get
     ```
   - **Backend**:
     ```sh
     cd server
     npm install
     ```

3. **Generate `.env` Files**
   - **In the root directory (`Scribble/.env`)**, create a `.env` file and add:
     ```env
     SERVER_URL=http://<youripaddress>:3000
     ```
   - **In the `server` folder (`Scribble/server/.env`)**, create a `.env` file and add:
     ```env
     MONGO_URI=mongodb+srv://<username>:<password>@cluster.mongodb.net/<dbname>?retryWrites=true&w=majority
     PORT=3000
     ```
     > **Note:** You need to create a **MongoDB Atlas Cluster**, get the **connection URL**, and replace `<username>`, `<password>`, and `<dbname>` accordingly.

4. **Run the Application**
   - **Start the backend server**:
     ```sh
     cd server
     node index.js
     ```
   - **Run the Flutter app**:
     ```sh
     cd ..
     flutter run
     ```

## Team Members
- [Atharv Jagzap](https://github.com/ajax-39)
- [Amogh Deshpande](https://github.com/Amogh050)
- [Pratik Baviskar](https://github.com/PratikBav)
<!-- Add all team members with their GitHub profiles if possible -->
