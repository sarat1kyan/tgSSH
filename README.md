                                 
       _       _____ _____ _____ 
      | |_ ___|   __|   __|  |  |
      |  _| . |__   |__   |     |
      |_| |_  |_____|_____|__|__|
          |___|                  


# tgSSH
📡 tgSSH: Control Your Linux Server via Telegram Bot 🚀

**Introduction**

tgSSH is a simple yet powerful tool that enables you to control your Linux server with the help of a Telegram bot. Be it an IT administrator or a cybersecurity specialist, tgSSH provides an ability to run remotely right in the comfort of your Telegram app a series of commands on your server.

This tool is developed with security and usability in mind, offering an ultimate fast solution for managing your server on-the-move. You simply need to provide your Telegram bot token, chat ID, and SSH credentials, and then you are good to go, anywhere in the world, and control your server!

**Features** ✨

	•	Remote Command Execution: Run any shell command on your Linux server via Telegram messages.
	•	Multi-Distribution Support: Automatically detects and installs required packages on various Linux distributions.
	•	Secure Communication: Uses SSH for secure server communication.
	•	Simple Setup: Easy to set up and run with minimal dependencies.
	•	Logging: Detailed logging for monitoring bot activity.

**Prerequisites** 🛠️

Before you begin, ensure you have the following:

	•	A Linux server with SSH access.
	•	A Telegram bot token (You can create one using BotFather).
	•	Your Telegram chat ID.
	•	Python 3.x installed on your server.

**Installation** 🔧

1. Clone the Repository
	
	git clone https://github.com/yourusername/tgSSH.git
	cd tgSSH

4. Run the Setup Script

Execute the setup script that installs necessary dependencies and configures the environment.

    $ chmod +x setup.sh
    $ sudo ./setup.sh

3. Provide Required Credentials

During the script execution, you will be prompted to enter:

	•	Telegram Bot Token: The token of the Telegram bot you created.
	•	Telegram Chat ID: Your Telegram chat ID.
	•	SSH Host IP: The IP address of your Linux server.
	•	SSH Username: The username for SSH login.
	•	SSH Password: The password for SSH login (consider setting up SSH key authentication instead).

The script will automatically install Python 3, pip, and sshpass, as well as the necessary Python libraries (telegram, paramiko).

4. Start Using tgSSH

Once the setup is complete, the Telegram bot will be ready to receive commands from you! Simply send any shell command to the bot, and it will execute it on your server and send the output back to you.

**Usage** 🖥️

After setting up the bot, you can start sending commands to your server via Telegram:

$ ls -la
$ df -h
$ sudo reboot
$ sudo systemctl status service-name
$ ping -c 4 example.com
$ e.t.c

The bot will execute these commands on the server and return the results directly to your Telegram chat.

Security Considerations 🔒

	•	SSH Key Authentication: We strongly recommend using SSH key-based authentication instead of passwords for increased security.
	•	Bot Security: Make sure your bot token and chat ID are kept secret to prevent unauthorized access.
	•	Environment Variables: Sensitive data such as your bot token and SSH credentials are stored in environment variables during runtime, but consider using a more secure storage solution for production environments.

**Troubleshooting** 🛠️

If you encounter any issues during setup or usage, please check the following:

	•	Ensure you are running the script as root or with sudo.
	•	Verify that the SSH service is running on your server.
	•	Double-check your Telegram bot token and chat ID.

**Contributing** 🤝

We welcome contributions! If you’d like to contribute to this project, please fork the repository and submit a pull request.

**License** 📄

This project is licensed under the MIT License. See the LICENSE.txt file for details.
