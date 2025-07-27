# RoboRally Server

This is my hobby project which aims at writing a program that allows people to play the boardgame RoboRally "by-mail".
This will provide a website interface where people can login and see a list of all their games. For those games in progress, one can see the current state of the board and decide what movement cards to play for their current turn. Once all users have entered their turn, the server will perform all the moves and calculate what happens, and a new turn becomes available.

This is the main project that contains the business logic of the server. Other parts of the project are:
- A Mysql database (or any other sql database)
- The project RRLibrary to provide the RoboRally specific logic needed for the server, see https://github.com/kharybdys/RRLibrary
- The project RRWeb to provide the website interface, see https://github.com/kharybdys/RRWeb

This project uses the open-source Navajo and Tipi (Vaadin) implementations as can be found at https://github.com/Dexels/navajo for the Server and Website respectively

If you want to contribute take a look at the issues list. Issues that require knowledge of the boardgame RoboRally will start with (RoboRally). Fork the repository and shoot me pull requests ;)

##

I have deprecated this project when I moved companies, see [https://github.com/kharybdys/roborally] for the restart
