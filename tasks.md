## Understand and Use Essential Tools

- ***Task 1 :***<br> 
	Find all setuid files on the system and save the list
```
 # find / -type f -perm -4000 > setuid_list
```
-  ***Task 2 :*** <br> 
	Find all log messages in /var/log/messages that contain "ACPI", and export them to a file called /root/logs. 
	Then archive all of /var/log and save it to /tmp/log_archive.tgz

```
# sudo grep ACPI /var/log/messages >> /root/logs
# tar cvf /tmp/log_archive.tgz /var/log/ 
```
- ***Task 3 :*** <br> 
	Create tar files compressed with gzip and bzip2 of /home and extract them

```
    Gzip: 
  # cd /tmp/ 
  # tar cvfz home.tar.gz /home
  # tar -tf home.tar.gz
  # tar xvfz home.tar.gz
  # rm -rf home
  # rm -rf home.tar.gz

   Bzip2: 
  # cd /tmp/
  # tar cvfj home.tar.bz2 /home
  # tar -tf home.tar.bz2
  # tar xvfj home.tar.bz2
  # rm -rf /home
  # rm -rf home.tar.bz2
```
-  ***Task 4 :***<br> 
	Create an empty file hard1 under /tmp and display its attributes. 
	Create hard links hard2 and hard3. Edit hard2 and observe the attributes. Remove hard1 and hard3 and list the attributes again

```
  # cd /tmp
  # touch hard1
  # ls -li hard1     
  
  # ln hard1 hard2 
  # ln hard1 hard3
  
  # echo "Redhat" > hard2
  # ls -li			  ==> They have the same inode 
  # rm -f hard{1,3}
  # ls -li 
```
-  ***Task 5 :***<br> 
	Create an empty file soft1 under /root pointing to /tmp/hard2. Edit soft1 and list the attributes after editing. Remove hard2 and then list soft1

```
  # ln -s /tmp/hard2 /root/soft1
  # ls -li /root/soft1  
  # echo "from soft1" >> /root/soft1
  # ls -li soft1 /tmp/hard2
  # rm -f /tmp/hard2		==> The link is broken 
  # rm -rf soft1
```
-  ***Task 6 :***<br> 
	 Create a file perm_file1 with read permissions for owner, group and other. 
	 Add an execute bit for the owner and a write bit for group and public. 
	 Revoke the write bit from public and assign read, write, and execute bits to the three user categories at the same time. 
	 Revoke write from the owning group and revoke write and execute bits from public
```
  # touch perm_file1
  # chmod 444 perm_file1
  # chmod u+x,g+w,o+w perm_file1 
  # chmod o-w,a=rwx perm_file1 
  # chmod g-w o-wx perm_file1 
```
### Operate running systems 

-  ***Task 0 :***<br> 
	Add the custom repositories for the Lab environment

```
# vim /etc/yum.repos.d/localRepo.repo

[Base]
name=BaseOS
baseurl=http://repo.eight.example.com/BaseOS
enabled=1

[AppStream]
name=AppStream
baseurl=http://repo.eight.example.com/AppStream
enabled=1

# dnf update

```

-  ***Task 1 :***<br> 
	Modify the GRUB timeout and make it 1 second instead of 5 seconds

```
 Any change to /etc/default/grub require rebuilding the grub.cfg 
# vim /etc/default/grub 
   GRUB_TIMEOUT=1
- On BIOS-based machine : 
# grub2-mkconfig -o /boot/grub2/grub.cfg	
- On UEFI-based machine : 
# grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
# reboot 
	To determine if the system is booted on BIOS or UEFI mode 
	 # dmesg | egrep -i "efi|bios"	
```

-  ***Task 2 :***<br> 
	Terminate the boot process at an early stage to access a debug shell to reset the root password
```
 == after you reboot the machine | press e to the specific kernel 
 and add rd.break after rgb quiet 
 # mount -o remount,rw /sysroot 
 # chroot /sysroot
 # passwd		==> changing the pass 
 # touch /.autorelabel
 # exit 
 # reboot

If you follow this approach and you have a large data set then the process of relabling by  SELinux takes more time, so to save some time you can add the option: 
rd.break enforcing=0 (without create the /.autorelabel file)

   After resetting the password do:   
 # restorecon -v /etc/shadow
 # setenforce 1
```
-  ***Task 3 :***<br> 
	 Download the latest available kernel packages from the Red Hat Customer Portal and install them 
```
To check out the kernel package information you can use dnf : 
# dnf info kernel 
To update to the latest  kernel 
# dnf install kernel --best 
# reboot

```
-  ***Task 4 :***<br> 
	 Install the tuned service, start it and enable it for auto-restart upon reboot. Display all available profiles and the current active profile. Switch to one of the available profiles and confirm. Determine the recommended profile for the system and switch to it. Deactive tuning and reactivate it
```
# systemctl status tuned.service	=> Check if the service is installed 
# dnf install tuned 
# tuned-adm list 
# tuned-adm profile powersave 
# tuned-adm active			=> to confirm which of the profile is active
# tuned-adm off
# tuned-adm profile $(tuned-adm recommned)
```
-  ***Task 5:***<br> 
	Launch the command dd if=/dev/zero of=/dev/null three times as a background job.
	Increase the priority of one of these ps
	Change the priority of the same process again, but this time use the value -15. Observe the difference.
	Kill all the dd processes you just started
```
# dd if=/dev/zero of=/dev/null & 
# dd if=/dev/zero of=/dev/null & 
# dd if=/dev/zero of=/dev/null & 
# ps aux | grep "dd " 
# renice -n 5 -p PID 
# sudo renice -n -15 -p PID		
# killall dd 
# jobs 
```
-  ***Task 6 :***<br> 
	Configure the journal to be persistent across system reboots.
	Make a configuration file that writes all messages with an info priority to the file /var/log/messages.info.
	Configure logrotate to keep ten old versions of log files
```
# vim /etc/systemd/journald.conf
	#uncomment storage line to persistent, a dir in /var/log/journal/ will be created
	Storage=persistent
# systemctl restart systemd-journald.service 
# ls /var/log/journal 
 " by restarting the systemd-journald , you 'll loose all the logging of the current session 
 so it's recommended to do the following cmd : 
# killall -USR1 systemd-journald 

# vim /etc/rsyslog.d/info.conf
	*.info			/var/log/messages.info
# systemctl restart rsyslog
# logger -p daemon.info "This message is from Task 6" 
# tail /var/log/messages.info
 Configure logrotate: 
# vim /etc/logrotate.conf
	rotate 10 
```
-  ***Task 7:***<br> 
	Copy the /etc/hosts file to the /tmp direcotry on server2 using scp command. 
	Try to connect to server2 as user root and copy the /etc/passwd file to you home direcotry 
```
# scp /etc/hosts server2:/tmp/
# scp server2:/etc/passwd ~
```

-  ***Task 8 :***<br> 
	Donwload and install the apache web service. try to configure apache to log error messages through syslog using the facility local1
	Create a rule that send all messages that it receives from local1 (That used above) facility to /var/log/httpd-error.log  
	verify the last changed by accessing a page that does not exist 
```
# dnf install -y httpd 
# vim /etc/httpd/conf/http.conf
	# adding the line 
	ErrorLog	syslog:local1
# systemctl restart httpd 
# vim /etc/rsyslog.conf
	# adding the following line in rule section 
	local1.error		/var/log/httpd-error.log
# systemctl restart rsyslogd
# curl localhost 	

```


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
