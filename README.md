# MQU Coffee Ordering App

This Flutter application allows users to order coffee from various cafes within the Macquarie University campus. At present the current version carries out a transaction with Firebase. Orders are stored within Firestore and information about orders are sent there.

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/73d7193e-a37b-4e15-a7ca-2356b78591e1)

User can choose to go to a particular function of the app from the homepage too using the picklist option which directs the user to the chosen function's page. At present, all buttons direct users to Boost of Caffeine. 
**Future Recommendation** would be to implement each option to a different functionality.

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/f39fbbc0-9fc9-4201-84f3-b96f32646067)


I have used a colourscheme which is very much easy on the eye for everyone and one that is familiar to all MQU students and staff. I acquired these colours from the MQU website. [MQ Brand Guidelines - Colour](https://gem.mq.edu.au/guidelines/colour)


If the user presses the "coffee cup" which appears upon entering the Boost Of Caffeine feature, they will be able to see their previous orders. As new orders are completed, the order details are sent to Firestore and stored in Order History. I will be storing three previous orders for the demo. 

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/d2ab2e5e-84e0-4a22-a165-9e734bbc5a0f) ![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/49c30ce0-e591-4b74-b85b-126529de57b4)
![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/c9a69ab7-f1c2-4543-97bd-cb217af173d8)


The Boost of Caffeine Homepage features a picklist of cafes to choose from with the address after the ",". Upon choosing a cafe, a map appears below with a map_marker and a square box to highlight the location of the cafe on the map. The map is zoomable with the mouse in the demo version and pinch when on a phone. A hint comes up above the map to let the user know about the action. Once the user confirms the cafe they want to order from, intended to be a dynamically changing menu dependant on the cafe they choose appears. At present this is contrained to ESC Cafe and it's logo only. More cafes are to be added for later versions in a similar manner as present. They can also zoom out by double tapping on the screen. 

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/56deaf3d-d75a-4194-91e7-007b9a9c6e91)


Upon entering the cafe page, the user will first be greeted with a Searchbar and a view cart button. With no items added, when view cart button is pressed, a dialog box comes up displaying "Cart is Empty" would come up.

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/08fd08a4-a8e9-4c51-891d-e8bccc0ef30f)

The Searchbar filters the items only presently with recommendation based search is suggested for **future implementations**.

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/47d2a872-b781-4ef0-90a7-531c525ef62a)


Actionable buttons ("+" and "-") are currently present with the quantity being ordered present in the middle. Under the items, are Prices of each product and a dynamically changing Total value of the items below that. Currently, only 1 size of drink is being offered for this demo. Prices shown are only for demo purposes. The user can also update their order before confirming it by going back to "Cafe Menu" Screen even after pressing "View Cart". They can adjust their order that way and confirm their favourite order.

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/bf18503a-ed8f-4486-93f4-0a6f05e9d049)


Furthermore, the app also has a validation check present for invalid credit card details. I have used a check for the first 2 digits which checks if the card exists for a valid credit card company. A validation check also exists for the expiry date, where older months are not accepted. The card payment also features gaps between every 4 digits and a maximum of 16 digits. Invalid month number i.e. < 1 or > 12 is not accepted and returns invalid card info upon pressing Pay Now. Only valid and confirmed orders go through to the Firestore as intended. 

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/912f0dcb-19f5-45b5-9675-3b1de8df8a7b)

Alternatively, the user can choose to "Pay at Counter" or via Apple/Google Pay and they are directed to the order confirmation screen. This is when a new order is sent for confirmed orders to Firebase. **Future recommendation** would be to send confirmation of order at POS for "Pay at Counter" option, since otherwise the order is not truly confirmed. Order history retains all these orders, which are retrieved from Firebase. **Future Recommendation** is that a functionality to star their order or even re-order that particular from the Order History.

![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/568968f0-e887-4b78-9f43-29ddb4111576)


![image](https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee/assets/79468514/f1b677cb-a8d3-4a52-8aa6-3140e228ffed)


For Navigation, through the whole Boost of Caffeine flow, there are back buttons present at the top left corner and a home button at the top right corner, for ease of access.


### Features

- Browse cafes and their menus
- Place orders for pickup
- View order history

### Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.
Prerequisites

- Flutter SDK
- Firebase account
- IDE (e.g., Android Studio, VS Code)

### Installation

  1. Clone the repository:

    bash git clone https://github.com/MQCOMP3130-2024/comp3130-major-work-kmrakeenabtahee.git

  2. Navigate to the project directory:

    bash cd mqu_coffee_app

  3. Install dependencies:

    bash flutter pub get

  4. Run the app:
     
    bash flutter run

    
  
### Documentation

- **Code Documentation**

  The code is well-documented with comments explaining the functionality of each module, class, and method.
    Each widget and function in the UI components is documented to provide insights into their purpose and usage.

- **Code and tests**
  
  All source codes can be found under MQU_APP/lib and all assets under MQU_APP/assets. Tests can be found under MQU_APP/test.

- **README**

  The README.md file provides an overview of the project, including its features, installation instructions, and prerequisites.
    It guides users through the process of setting up the project locally and running it on their machine.
    Additional information about integrating Firebase and other dependencies is included in the installation section.
    Contributors are encouraged to update the README.md file when making changes to the project to keep it up-to-date and helpful for future developers.
