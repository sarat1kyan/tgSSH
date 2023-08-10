import telegram
import paramiko
import os
import sys
import logging
from telegram.ext import Updater, MessageHandler, Filters, CommandHandler, CallbackContext

# Set up logging
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

# Get the required inputs from environment variables
bot_token = os.environ.get('BOT_TOKEN')
chat_id = os.environ.get('CHAT_ID')
ssh_hostname = os.environ.get('SSH_HOSTNAME')
ssh_username = os.environ.get('SSH_USERNAME')
ssh_password = os.environ.get('SSH_PASSWORD')

# Create a new Telegram bot using the provided token
bot = telegram.Bot(token=bot_token)

# Define a function to execute a command on the remote Linux server
def execute_command(command):
    try:
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
    except Exception as e:
        logger.error(f"Error executing command: {e}")
        return f"Error executing command: {e}"

# Define a function to handle incoming Telegram messages
def handle_message(update, context):
    try:
        # Get the text of the incoming message
        message_text = update.message.text

        # Execute the command on the remote Linux server
        output = execute_command(message_text)

        # Send the output of the command back to the user via Telegram
        bot.send_message(chat_id=chat_id, text=output)
    except Exception as e:
        logger.error(f"Error handling message: {e}")

def main():
    try:
        # Create a Telegram bot updater and add the message handler
        updater = Updater(token=bot_token, use_context=True)
        updater.dispatcher.add_handler(MessageHandler(Filters.text & ~Filters.command, handle_message))

        # Start the bot
        updater.start_polling()

        # Run the bot until it is stopped
        updater.idle()
    except Exception as e:
        logger.error(f"Bot execution error: {e}")

if __name__ == "__main__":
    main()
