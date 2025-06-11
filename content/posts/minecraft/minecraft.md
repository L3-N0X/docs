---
author: ["Leon Gött"]
title: "Minecraft Server Guide"
date: "2025-06-11"
description: "Set up a Minecraft server with ease using this comprehensive guide."
summary: "Set up a Minecraft server with ease using this comprehensive guide."
tags: ["minecraft", "server", "guide"]
categories: ["minecraft", "server"]
series: ["Minecraft Guide"]
ShowToc: true
TocOpen: true
---

# Minecraft Server Guide

This guide will help you set up a Minecraft server on your local machine or a dedicated server. Follow the steps below to get started.

## Prerequisites

- A computer with at least 2GB of RAM (4GB recommended)
- Java 17 or later installed
- A stable internet connection
- Basic knowledge of command line operations
- A Minecraft account
- (Optional) A static IP address or dynamic DNS service if you want to host the server for others to join

## Step 1: Download the Minecraft Server Software

1. Go to the [official Minecraft server download page](https://www.minecraft.net/en-us/download/server).
2. Download the latest version of the server software (a `.jar` file).
3. Create a new folder on your computer where you want to run the server (e.g., `C:\MinecraftServer` or `/home/user/MinecraftServer`).
4. Move the downloaded `.jar` file into this folder.

## Step 2: Set Up the Server

1. Open a command prompt or terminal window.
2. Navigate to the folder where you placed the server `.jar` file. For example:
   - On Windows: `cd C:\MinecraftServer`
   - On Linux/Mac: `cd /home/user/MinecraftServer`
   - On macOS: `cd ~/MinecraftServer`
3. Run the server with the following command:
   ```bash
    java -Xmx1024M -Xms1024M -jar server.jar nogui
    ```
    Replace `server.jar` with the actual name of the downloaded file if it differs.
4. The server will start and generate some files, including `eula.txt`. You need to accept the EULA to continue.
5. Open the `eula.txt` file in a text editor and change `eula=false` to `eula=true`. Save the file.
6. Run the server command again:
   ```bash
   java -Xmx1024M -Xms1024M -jar server.jar nogui
   ```
7. The server will start, and you should see messages indicating that it is running.

## Step 3: Configure the Server

You can customize your server settings by editing the `server.properties` file in the server folder. Here are some common settings you might want to change:
- `server-name`: Set the name of your server.
- `max-players`: Set the maximum number of players allowed on the server.
- `level-name`: Set the name of the world.
- `gamemode`: Set the default game mode (e.g., `survival`, `creative`, `adventure`).
- `difficulty`: Set the difficulty level (e.g., `peaceful`, `easy`, `normal`, `hard`).
- `online-mode`: Set to `true` to require players to log in with a valid Minecraft account.
