# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"
# The script then extracts the .txt file using gunzip.
gunzip web-server-access-log.txt.gz

# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.
# Extract phase

echo "Extracting data"

# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and 
# 4 (visitorid)



# Transforms the text delimeter from "#" to "," and saves to a csv file.
cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt
tr "#" "," < extracted-data.txt > transformed-data.csv
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.


echo '\c template1; \\CREATE TABLE access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));' | psql --username=postgres --host=localhost

# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.

echo "\c template1;\COPY access_log  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost