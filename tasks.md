## Emergency

- Reset root password via Grub;


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
