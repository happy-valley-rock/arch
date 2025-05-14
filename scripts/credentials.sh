#!/bin/bash

# Encrypted file name
CRED_FILE="${SCRIPT_PATH}/credentials.enc"
SECRET_KEY=
SECRET_PARAM_KEY=$1

read_secret_key() {
	if [[ -z "$SECRET_PARAM_KEY" ]]; then
		echo -e "${BLUE}==> Enter your secret key\n${GRAY}"
		read -sp "> secret key: " SECRET_KEY
		echo "******"
	else
		echo -e "${BLUE}==> Secret key detected${GRAY}"
		SECRET_KEY=$SECRET_PARAM_KEY
	fi
}

# Function to prompt for credentials and create the encrypted file
create_credentials() {
	echo -e "\n${BLUE}==> Enter your credentials${GRAY}"

	read -p "> username: " input_username
	read -sp "> password: " input_password
  echo "******"
	read -sp "> email: " input_email
	echo "******"

	# Create temporary plain text file
	temp_file=$(mktemp)
	echo "username=$input_username" > "$temp_file"
	echo "password=$input_password" >> "$temp_file"
	echo "email=$input_email" >> "$temp_file"

	# Encrypt the file
	openssl enc -aes-256-cbc -salt -in "$temp_file" -out "$CRED_FILE" -k "$SECRET_KEY"

	# Remove temp file
	rm -f "$temp_file"
	echo -e "${BLUE}  -> Credentials encrypted and saved to $CRED_FILE${GRAY}"
}

# Function to decrypt and load the credentials into variables
load_credentials() {
	if [ ! -f "$CRED_FILE" ]; then
			echo -e "\n${BLUE}==>  Encrypted credentials file not found${GRAY}"
			return 1
	fi

	# Decrypt and evaluate the file content to set variables
	eval $(openssl enc -aes-256-cbc -d -in "$CRED_FILE" -k "$SECRET_KEY" 2>/dev/null)

	# Assign to global variables
	USER_INPUT="$username"
	PASS_INPUT="$password"
	EMAIL_INPUT="$email"
}

# Main function
set_credentials() {
	read_secret_key

	if [[ -z "$SECRET_KEY" ]]; then
		exit 1
	fi

	if [ -f "$CRED_FILE" ]; then
		echo -e "${BLUE}==>  Encrypted credentials detected. Loading...${GRAY}"
		load_credentials || exit 1
	else
		create_credentials
		load_credentials
	fi

	echo
	echo -e "${BLUE}==>  Loaded variables:${GRAY}"
	echo -e "${GREEN}  -> username: $USER_INPUT"
	echo -e "${GREEN}  -> password: *****"
	echo -e "${GREEN}  -> email: *****${GRAY}"

	# You can now use $USER_INPUT, $PASS_INPUT, and $EMAIL_INPUT in the rest of your script
}
