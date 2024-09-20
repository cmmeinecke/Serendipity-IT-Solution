#!/bin/bash

#Linux Administration Menu created by Caitlin Meinecke

# Function to display the main menu with admin options
main_menu() {
    clear
    echo "--------------------------------------"
    echo " Serendipity IT Solutions                "
    echo "--------------------------------------"
    echo "1. Reboot or Shutdown Device"
    echo "2. View and Edit Files"
    echo "3. Manage Users"
    echo "4. Manage File Ownership"
    echo "5. View and Edit Timezones"
    echo "6. Zip and Unzip Files"
    echo "7. Share Files with Windows host"
    echo "8. Exit"
    echo "--------------------------------------"
    echo -n "Enter your selection: "
}
# Function for rebooting or shutting down the device
reboot_shutdown() {
    clear
    echo "--------------------------------------"
    echo "      Reboot & Shutdown Menu          "
    echo "--------------------------------------"
    echo "1. Reboot"
    echo "2. Shutdown"
    echo "3. Cancel"
    echo "--------------------------------------"
    echo -n "Enter your selection: "
    read select

    case $select in
		#reboot device
        1)
            echo "Rebooting the device now..."
            reboot
            ;;
		#shutdown device
        2)
            echo "Shutting down the device now..."
            shutdown -h now
            ;;
        3) return ;;
        *) echo "Invalid selection. Please enter a number from 1 to 3." ;;
    esac
}
# Function for viewing or editing the contents of a specified file
view_or_edit_file() {
    clear
    echo "--------------------------------------"
    echo "  View or Edit File Contents        "
    echo "--------------------------------------"
    echo -n "Enter the file name: "
    read file

	#if statement that first verifies the file exists, then gives the user options to view or edit the selected file
    if [ -f "$file" ]; then
        echo "1. View File Contents"
        echo "2. Edit File"
        echo "3. Cancel"
        echo "--------------------------------------"
        echo -n "Enter your selection: "
        read select
		
        case $select in
			#cat command to view contents of file
            1)
                echo "Contents of $file:"
                cat "$file"
                ;;
			#vi command to edit file
            2)
                echo "Editing $file..."
                vi "$file"
                ;;
            3) return ;;
            *) echo "Invalid choice. Please enter a number from 1 to 3." ;;
        esac
    else
        echo "File '$file' does not exist."
    fi
}

# Function for adding or deleting a user
add_or_delete_user() {
    clear
    echo "--------------------------------------"
    echo "     Add or Delete User Menu        "
    echo "--------------------------------------"
    echo "1. Add a User"
    echo "2. Delete User"
    echo "3. Cancel"
    echo "--------------------------------------"
    echo -n "Enter your selection: "
    read select

    case $select in
        1)
			#adduser command to add a user
            echo -n "Enter the username for the new user: "
            read username
            adduser "$username"
			echo "User added."
            ;;
        2)
			#userdel command to delete user
            echo -n "Enter the username to delete: "
            read username
            sudo userdel -r "$username"
			echo "User deleted."
            ;;
        3) return ;;
        *) echo "Invalid choice. Please enter a number from 1 to 3." ;;
    esac
}

# Function for changing the owner and setting permissions of a file
owner_permissions() {
    clear
    echo "----------------------------------------"
    echo "  Change Owner or Permissions of a File   "
    echo "----------------------------------------"
    echo "1. Change Owner"
    echo "2. Set Read-Only Permission"
    echo "3. Set Write-Only Permission"
    echo "4. Set Read & Write Permission"
	echo "5. Cancel"
    echo "--------------------------------------"
    echo -n "Enter your selection: "
    read select

    case $select in
		#chown command to change onwer of a file
        1)
            echo -n "Enter the username of the new owner: "

            read new_owner_username
            echo -n "Enter the file name: "
            read file
            sudo chown "$new_owner_username" "$file"
            echo "Owner of '$file' changed to '$new_owner_username'."
            ;;
		#chmod 400 sets read-only permission to a file
        2)
            echo -n "Enter the file name: "
            read file
            sudo chmod 400 "$file"
            echo "Read-only permission set for '$file'."
            ;;
		#chmod 200 sets write-only permission to a file
        3)
            echo -n "Enter the file name: "
            read file
            sudo chmod 200 "$file"
            echo "Write-only permission set for '$file'."
            ;;
		#chmod 600 sets both read and write permissions to a file
        4)  echo -n "Enter the file name: "
            read file
            sudo chmod 600 "$file"
            echo "Read and Write permission set for '$file'."
            ;;
        5) return ;;
        *) echo "Invalid choice. Please enter a number from 1 to 5." ;;
    esac
}


# Function for viewing or changing the timezone
view_or_change_timezone() {
    clear
    echo "-------------------------------------"
    echo "     View or Change Timezone        "
    echo "-------------------------------------"
    echo "1. View Current Timezone"
    echo "2. Change Timezone"
    echo "3. Cancel"
    echo "-------------------------------------"
    echo -n "Enter your choice: "
    read select

    case $select in
		#timedatectl | grep command to display the current timezone of the device
        1)
            echo "Current Timezone:"
            timedatectl | grep "Time zone"
            ;;
		#timedatectl set-timezone command to change the timezone of the device
        2)
            echo -n "Enter the new timezone (for example: America/New_York): "
            read timezone
            timedatectl set-timezone "$timezone"
            echo "Timezone set to '$timezone'."
            ;;
        3) return ;;
        *) echo "Invalid choice. Please enter a number from 1 to 3." ;;
    esac
}

# Function for compressing, uncompressing, and viewing files
zip_unzip_() {
    echo "---------------------------------------"
    echo "     Zip or Unzip Files       "
    echo "---------------------------------------"
    echo "1. Zip a File"
    echo "2. Unzip a File"
    echo "3. Cancel"
    echo "---------------------------------------"
    echo -n "Enter your selection: "
    read select

    case $select in
		#if statement that verifies if the file exists, then zips the file 
        1)
            echo -n "Enter the name of the file to zip: "
            read file
            if [ -f "$file" ]; then
                zip "${file}.zip" "$file"
                echo "File zipped."
            else
                echo "File '$file' does not exist."
            fi
            ;;
		#if statement that verifies if the file exists, the unzips the file
        2)
            echo -n "Enter the name of the file to unzip: "
            read compressed_file
            if [ -f "$compressed_file" ]; then
                unzip "$compressed_file"
                echo "File unzipped."
            else
                echo "File '$compressed_file' does not exist."
            fi
            ;;
        3) return ;;
        *) echo "Invalid choice. Please enter a number from 1 to 3." ;;
    esac
}
# Function for sharing a file on a Linux device with the Windows host device
share_files() {
    clear
    echo "--------------------------------------"
    echo "       Share Files        "
    echo "--------------------------------------"
    echo -n "Enter the path of the file to share: "
    read file_path
	#if statement that verifies the file path exists and the copies a file to the shared folder that is shared with the Windows hosts
    if [ -f "$file_path" ]; then
        # this is the Linux file that is used to share files to the Windows Host
        shared_directory="/media/sf_Share"
        
        # Copy the file to the shared directory
        cp "$file_path" "$shared_directory"
        
        echo "File '$file_path' shared with the host."
    else
        echo "File '$file_path' does not exist."
    fi
}

# loop statement to display the menu
while true; do
    main_menu
    read select
	
	#executes the menu options
    case $select in
        1) reboot_shutdown ;;
        2) view_or_edit_file ;;
        3) add_or_delete_user ;;
        4) owner_permissions;;
        5) view_or_change_timezone ;;
        6) zip_unzip_ ;;
        7) share_files ;;
        8) exit ;;
        *) echo "Invalid choice. Please enter a number from 1 to 8." ;;
    esac
    echo "Press Enter to continue..."
    read
done
