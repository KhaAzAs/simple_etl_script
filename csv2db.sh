# This script extracts data from /etc/passwd file into a CSV file.

# The csv file contains the user name, user id and
# home directory of each user account defioed in /etc/passwd

# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.

# Extract phase
echo "Extracting data"

# Extract the columns 1 (usename), 2 (user id) and
# 6 (home directory path) from /etc/passswd
cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt

# Transform phase
echo "Transforming data"

# Read the extracted data and replace the colons with comms.
tr ":" "," < extracted-data.txt > transformed-data.csv

# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'users' through comand pipeline.
echo "\c template1;\COPY users FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=localhost