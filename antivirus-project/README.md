#Antivirus project

#Overview

	This is a simple antivirus project for Ubuntu/Linux. It works on two important concepts:
		1. Detecting malicious files and quarantining them
		2. Recovery process for the quarantined files.

#MUST HAVES
The main folder that will have the files: dir/
The working files: restore.sh antivirusd.sh
The makefile : Makefile

#Starting
To start the program, open the terminal and run: make setup
This will create the malicious_dir folder, if not there, to prepare the program.

To run the antivirus : make antivirus
NOTE! The antivirus will run in infinite loop until the user presses : CTRL + C to stop executing.
NOTE! The antivirus run the scan every 7 seconds, to adjust the seconds, run the following command:
./antivirusd.sh dir malicious_dir (Desired seconds)
If you do no wish to change the seconds, ignore the last note.

Each time a malicious file is detected, a message will appear indiciating which file was detected as malicious.
The file would be removed permenantly from the dir/ folder, and moved to the malicious_dir for furthur actions (later handled by restore.sh)


It takes directory snapshots using (ls -l), compares with cmp and only scan when there's a change.
After the scan, it updates directory-info.last to show the current content of dir/ after that scan.
On the first run, it scans immediately.

#What's considered malicious
	1. The following extensions : .exe .bat .vbs .scr .ps1
	2. The following keywords: virus, trojan, malware, worm, ransomware
NOTE! test.txt.scr would be FLAGGED while test.txt.scr.txt WONT BE FLAGGED
NOTE! The keywords are case insensitive : virus and ViRus would both be FLAGGED


#Recovery process (restore.sh)
	To start the restore.sh, simply run the command: make restore
The file retore.sh is responsible on deciding what happens to the malicious files, regardless of it being malicious for extension or the content inside.
It uses an array to list the file names inside the malicious_dir folder.
The user has the option to choose from the numbered files, upon choosing the file the user will be in front of 3 options:
	1. Returning the file back to dir/ connsidering it was false positive
	2. Permenantly deleting the file considering it was truly malicious
	3. Leave as-is
Upon the user's choice, the action will be made.

	If no malicious files inside, a message will appear indicating so. Once no files inside, the restore.sh execution would be stopped.
"No malicious files to review" would be printed if no files in malicious_dir


#FOLDER HERICHERY

antivirusd.sh  restore.sh  antivirus-cron.sh  Makefile README.md  dir/  malicious_dir/ (malicious_dir/ would be created using make setup if not already created)  directory-info.last  directory-info.new

--dir/ is the folder with the main files to scan
--malicious_dir/ is for malciious files
--directory-info.last and directory-info.new are the snapshots created by the daemon during execution


#PREREQUISITIES AND INSTALL

Ubuntu/Linux and Bash: needed to run the scripts.
GNU Make: to run the Makefile
	install guide for makefile:
		sudo apt update
		sudo apt install make


#CRON

The cron service must be installed and running on Ubuntu.
The required : antivirus-cron.sh , dir/ , malicious_dir/


	If cron is not installed:
		sudo apt update
		sudo apt install cron
		sudo systemctl enable --now cron
	To make the script executable:
		chmod +x antivirus-cron.sh

TO CONFIGURE THE JOB:
	1. Open terminal and run pwd to get the project's full path
	2. crontab -e
	3. Add the following line replacing the path with the actual path:
* * * * * sleep 23; /FULL/PATH/antivirus-cron.sh /FULL/PATH/dir /FULL/PATH/malicious_dir
	4. Save and exit from the editor
	5. To ensure your work was saved : crontab -l
TO DISABLE THE CRON : Put a # before the given command
This will launch the cron automatically every minute, delayed by 23 seconds.




THIRD FRIDAY TASK:
	To run the scan every third Friday of the month at 12:31 AM use the following line with the actual paths:
31 0 * * 5 [ "$(date +\%d)" -ge 15 ] && [ "$(date +\%d)" -le 21 ] && /FULL/PATH/antivirus-cron.sh /FULL/PATH/dir /FULL/PATH/malicious_dir

	This schedule selects Fridays at 12:31 AM, while date checks restrict execution to dates from the 15th through the 21st, which contain the third Friday. The backslash before % is required in crontab command.
