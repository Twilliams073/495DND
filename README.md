# D&D Compendium

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Provides documentation for content relating to the tabletop roleplaying game, D&D.

### App Evaluation
- **Category:** Entertainment / Informational
- **Mobile:** Designed mainly for mobile use but could also be translated well into a website format.
- **Story:** Give players access to D&D related content and provide tools for running / playing a game.
- **Market:** Anyone looking to get help or remember certain information regarding to Dungeons and Dragons.
- **Habit:** The user may use this app very often to refer to the specifics of D&D content.
- **Scope:** First we want to create a searchable index of most D&D related content (i.e spells, classes, races, etc...). This can evolve into creating several tools to help players manage their games and character sheets.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users should be able to access different categories with various information
* Users should be able to make search requests for information
* Access to the basic rules of D&D

**Optional Nice-to-have Stories**

* Users can bookmark certain information that is saved across user accounts
* Users can create and manage characters within the app
* Users can roll virtual dice within the app
* 

### 2. Screen Archetypes

* Main Screen
   * The user is presented with a list of catagories
   * Choosing a catagory will take the user to the Sub-Category Screen for the chosen category
* Sub-Categories Screen
   * The user will be presented with a list of sub-categories in a table view.
   * There will be a search bar also allowing the user search sub-categories
* Detailed Information Screen
   * All individual specific informational screens will follow the same general format
   * Will display specific information for the specified sub-category

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Spells
* Equipment
* Races
* Classes
* Feats
* Backgrounds

**Flow Navigation** (Screen to Screen)

* Main Screen
   * => Sub-Category Screen
* Sub-Category Screen
   * => Detailed Information Screen
   * => Main Screen (Using back button)
* Detailed Information Screen
   * => Sub-Category Screen (Using back button)

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
