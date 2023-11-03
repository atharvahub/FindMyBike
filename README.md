# Bike Theft Prevention System

## Table of Contents
- [Introduction](#introduction)
- [Use Case](#use-case)
- [Main Requirements and Sub-Requirements](#main-requirements-and-sub-requirements)
- [System Design](#system-design)
- [Incremental Process](#incremental-process)
- [User Manual and Source Code Screenshots](#user-manual-and-source-code-screenshots)
- [References](#references)

## Introduction

This repository contains the source code and documentation for a software product designed to prevent theft of street bicycles. Traditional locks can be easily manipulated, leading to insecurity. This software uses a combination of GPS tracking, accelerometers, gyroscopic sensors, and a micro-controller to enhance bike security. It provides real-time location data for both the bike and the user and offers features like speed tracking, geo-fencing, and an anti-theft system.

## Use Case

[Include a brief description or image of the use case here if applicable]

## Main Requirements and Sub-Requirements

### A) GPS
- Live location of user and bike.
- Speed tracking using GPS coordinates.

### B) Real-Time Tracking
- Location of bike traced on the go.

### C) Geo-Fencing
- Circle of a predefined diameter in which the bike can move without restriction.
- Alerts when the bike goes out of this circle.

### D) Anti-theft System
- State of the bike's lock condition.
- Live location of the bike.

## System Design

[Include a system architecture diagram or image if applicable]

The system is designed to monitor bike locations and deter bike theft. Users must register themselves and their bikes within the system to access its capabilities. It offers real-time tracking, boundary alerts, and anti-theft features. The system can also serve as a navigation tool and track bike maintenance tasks.

## Incremental Process

The implementation of the anti-theft system is developed using an incremental process. Users need to log in, and if they are new customers, they must first register themselves and their bikes. The home page provides options to display the device's location, the bike's location, and the bike's status. Notifications are sent in case of any changes in the bike's condition, such as unauthorized attempts to unlock it.

## User Manual and Source Code Screenshots

1. Login in the application using the provided credentials.
   - Email: admin@gmail.com
   - Password: 12345
2. Once logged in, you will be directed to the home page with three buttons.
   - User location: Display the location of your device.
   - Bike location: Display the location of your bike.
   - Bike state: Display the condition of the bike (locked or unlocked).
3. Receive notifications for events like the unauthorized opening of the bike's lock.

[Include screenshots or images of the application's interface if applicable]

### Note:
- The source code zip file is attached to this document.
- To run the application, connect your Android device to your system and open the `main.dart` file. Run the file with Flutter, and the application will open on your Android device.
- A video demonstrating the system's functionality is attached to this file for reference.

## References

1. [Geolocator Package](https://pub.dev/packages/geolocator)
2. [Flutter Local Notifications Package](https://pub.dev/packages/flutter_local_notifications)
3. Prof. Bahareh Goodarzi PhD, COEN 6311 Fall 2023 Assignment1 Description
