# MusicAlbumApp

This is an educational application for finding music albums and viewing information about them.

## Getting started
The project does not require additional settings to run

## About project
The project is designed for educational purposes for training and practice

### When developing the project, the following tasks were set:

1. Registration screen with text field validate
- First name (only English).
- Second name (only English).
- Date of birthday (Choose with calendar and at least 18 years old).
- Phone number (Format: "+7 (***) ***-**-**" and +7 appear automatically after user entering first number.
- Email (with correctness check).
- Password (more 6 characters and at least 1 uppercase character, 1 lowercase character and at least 1 number).

2. Login screen with validate user information
- Email and password text fields
- Check user in database
- Present main module only for authorization user

3. Music album screen with searchBar and table View
- Show logo of found albums
- Show album name and count of track of found albums
- Show group name of found albums
- Search with Russian and English language

4. Detail album screen after tap of selected album
- Detail screen need contains album logo, album and group name, date of release and tracks list

### The following solutions were used in this project: 

- Swift language
- Foundation
- UIKit
- MVC Architecture
- Firebase
- Auto Layout
- JSON decode
- GCD
- TextField validate (Own implementation)
- Network manager (UrlSession)
- Only programmaticaly (without storyBoard)
- Navigation and routing without segue


### Modules:
- Starting module

This screen contains an image with the application logo, and allows you to choose to go to the registration or login module

- Login module

This screen contains 2 text fields for entering an email and a password, if authorization is successful, it presents the main screen

- Register module

This screen contains several text fields for entering user information, validation is implemented here.
If registration is successful, it presents the main screen

- Albums module (main)

This screen contains main table View and search bar.
When you enter text in the search field, the table begins to be updated with the values obtained using the API.
Navigation bar contains "Sign out" button and "About user" button

- About album module

This screen сontains information about the selected album, for example album name, date of release, track list and album logo

- About user module

This screen contains user information.
Only read, without change something

## Presentation

- Presentation video https://www.youtube.com/watch?v=9MRL9na7QKc

