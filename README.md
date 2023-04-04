# D&D Spellbook

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Provides a spellbook manager for Dungoens and Dragons players. These spellbooks will allow users to keep track of specific spells that they use and gain quick access to.

### App Evaluation
- **Category:** Entertainment / Management
- **Mobile:** Designed mainly for mobile use but could also be translated well into a website format.
- **Story:** Users can manage their characters spells through the app.
- **Market:** Anyone looking to be able to manage a list of spells for their characters.
- **Habit:** The user may use this app quite often during gameplay sessions to refer to their usable spells.
- **Scope:** First we want to creating user accounts and spellbook management per account. This may evolve into spellbook sharing or other management tools for D&D.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users are able to sign-up/login to access the app
* Users can add or remove spells from their spellbook
* Users should be able to view the details of a spell.

**Optional Nice-to-have Stories**

* Users can share spellbooks in the form of a link, pdf, or other sharable medium
* Users should be able to create and save more than one spellbook
* Users can also view spells from homebrew (non-official) sources

### 2. Screen Archetypes

* Login
* Register
    * Sign up or sign into their accounts
* Spell Books Screen
   * The user can view a list of spell books under their account
   * The user can select a spell book to view and edit
* Spells Screen
   * Displays specific information for spells
   * User can search for specific spells
* Specific Spell Book Screen
   * User can view spells within a spellbook

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Screen
* Spell Books
* Spells Screen

**Flow Navigation** (Screen to Screen)

* Login Screen
   * => Register Screen
   * => Main Screen
* Main Screen
   * => Spell books
   * => Spells
* Spell Books Screen
   * => Main Screen
   * => Spell Books Specific Screen
   * => (back button)
* Spell Book Specific Screen
   * => Spells screen
   * => (back button)
* Spells Screen
   * => (back button)

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
