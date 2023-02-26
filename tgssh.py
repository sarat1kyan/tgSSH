import telegram
import paramiko
import os
import sys

# Get the required inputs from the command line arguments
bot_token = sys.argv[1]
chat_id = sys.argv[2]
ssh_hostname = sys.argv[3]
ssh_username = sys.argv[4]
ssh_password = sys.argv[5]

# Create a new Telegram bot using the provided token
bot = telegram.Bot(token=bot_token)

# Define a function to execute a command on the remote Linux server
def execute_command(command):
    # Create an SSH client object
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    # Connect to the remote Linux server using SSH
    client.connect(ssh_hostname, username=ssh_username, password=ssh_password)
    
    # Execute the command on the remote Linux server
    stdin, stdout, stderr = client.exec_command(command)
    
    # Get the output of the command
    output = stdout.read().decode()
    
    # Close the SSH connection
    client.close()
    
    # Return the output of the command
    return output

# Define a function to handle incoming Telegram messages
def handle_message(update, context):
    # Get the text of the incoming message
    message_text = update.message.text
    
    # Execute the command on the remote Linux server
    output = execute_command(message_text)
    
    # Send the output of the command back to the user via Telegram
    bot.send_message(chat_id=chat_id, text=output)

# Create a Telegram bot updater and add the message handler
updater = telegram.ext.Updater(token=bot_token, use_context=True)
updater.dispatcher.add_handler(telegram.ext.MessageHandler(telegram.ext.Filters.text, handle_message))

# Start the bot
updater.start_polling()

# Run the bot until it is stopped
updater.idle()

