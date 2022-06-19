## Operations

- Reset root password via Grub;
- Install the tuned service, start it and enable it for auto-restart upon reboot. 
- Display all available Launch the command dd if=/dev/zero of=/dev/null three times as a background job. Increase the priority of one of these ps Change the priority of the same process again, but this time use the value -15. Observe the difference. Kill all the dd processes you just startedprofiles and the current active profile.
- Switch to one of the available profiles and confirm. 
- Determine the recommended profile for the system and switch to it. 
- Deactive tuning and reactivate it
- Launch the command dd if=/dev/zero of=/dev/null three times as a background job. 
- Increase the priority of one of these. 
- Change the priority of the same process again, but this time use the value -15.
- Kill all the dd processes you just started
- Confirm no more processes are running

## Deploy, Configure and Maintain Systems
- Check if Chrony is running
- List the available timezones
- Set the system time zone.
- Configure the system to use NTP
- Confirm your changes regarding NTP and timezone.

- Determine if the cifs-utils package is installed and if it is available for installation. Use both DNF and RPM
- Display its information before installing it. 
- Install the package and display its information again.
- Remove the package along with its dependencies and confirm the removal

## Firewall

- Determine the current active zone;
- Add and activate a permanent rule to allow HTTP traffic on port 80.
- Add a runtime rule for traffic intended for TCP port 443.
- Add a permanent rule to the internal zone for TCP port range 5901 to 5910. 
- Confirm the changes and display the contents of the affected zone files. 
- Switch the default zone to the internal zone and activate it.
- Confirm the active zones.

- Remove the 2 permanent rules added above. 
- Switch back to the public zone as the default zone, and confirm the changes

## Networking
- Set the system hostname to server1.example.com and alias server1.
- Restart the hostname service.
- Make sure that the new hostname is reflected in the command prompt.

## Users & Groups
- Create the instructors group
- Create three users (Derek, Tom, and Kenny) that belong to the instructors group.
- Prevent Tom's user from accessing a shell, and make his account expire 10 day from now
- Remove the users & groups created in the previous steps.

## Containers
