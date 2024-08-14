import telegram
import paramiko
import os
import logging
from telegram.ext import Updater, MessageHandler, Filters

logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

bot_token = os.getenv('BOT_TOKEN')
chat_id = os.getenv('CHAT_ID')
ssh_ip = os.getenv('SSH_IP')
ssh_username = os.getenv('SSH_USERNAME')
ssh_password = os.getenv('SSH_PASSWORD')

if not bot_token or not chat_id or not ssh_ip or not ssh_username or not ssh_password:
    logger.error("Missing required environment variables.")
    exit(1)

bot = telegram.Bot(token=bot_token)

def execute_command(command):
    try:
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        client.connect(ssh_ip, username=ssh_username, password=ssh_password)

        stdin, stdout, stderr = client.exec_command(command)

        output = stdout.read().decode()
        error = stderr.read().decode()

        client.close()

        if error:
            return f"Error: {error}"
        return output

    except Exception as e:
        logger.error(f"Error executing command: {e}")
        return f"Error executing command: {e}"

def handle_message(update, context):
    try:
        message_text = update.message.text

        output = execute_command(message_text)

        bot.send_message(chat_id=chat_id, text=output)
    except Exception as e:
        logger.error(f"Error handling message: {e}")
        bot.send_message(chat_id=chat_id, text=f"Error: {e}")

def main():
    try:
        updater = Updater(token=bot_token, use_context=True)
        updater.dispatcher.add_handler(MessageHandler(Filters.text & ~Filters.command, handle_message))

        updater.start_polling()

        updater.idle()
    except Exception as e:
        logger.error(f"Bot execution error: {e}")

if __name__ == "__main__":
    main()