# Project Overview
Egg-cellent Recipes is an application built using REST API and MySQL. It consists of three personas: users, chefs, and employees. Users could view the ingredients in their pantry, view the recipe of the week, and submit a help request form. Chefs could upload recipes to share with others and submit a help request form as well while employees could view the help requests sent by users and chefs.

Demo video: https://youtu.be/UhcU5ETnv4E 
 

# Instructions
<img width="439" alt="Screenshot 2022-12-11 at 7 43 50 PM" src="https://user-images.githubusercontent.com/91427854/206939309-3d836788-6ef0-4b17-a47e-f2fad2e7ef14.png">

- Select a persona to operate as in the general homepage

User homepage:

<img width="419" alt="Screenshot 2022-12-13 at 4 15 43 PM" src="https://user-images.githubusercontent.com/91427854/207445156-c1648dae-cbdc-4a4a-9864-0c87445c4d5d.png">

- Select "User Pantry" to view the ingredients in each user's pantry

- Select "Recipe of the Week" to view the top recipe chosen weekly

- Select "Help Request Form" to submit a help request to an employee

Chef homepage:

<img width="421" alt="Screenshot 2022-12-13 at 4 16 27 PM" src="https://user-images.githubusercontent.com/91427854/207445281-26019314-2ffc-4c28-b3f3-51a4c012bb0a.png">

- Select "Add Recipe" to upload a recipe

- Select "Help Request Form" to submit a help request to an employee

Employee homepage:

<img width="419" alt="Screenshot 2022-12-13 at 4 16 52 PM" src="https://user-images.githubusercontent.com/91427854/207445346-3e2f3e16-08da-4703-9da9-b2e7a10de7eb.png">

- Select "View Help Forms" to see all the help requests users and chefs have submitted in the past


# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 2 docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## For setting up a Conda Web-Dev environment:

1. `conda create -n webdev python=3.9`
1. `conda activate webdev`
1. `pip install flask flask-mysql flask-restful cryptography flask-login`




