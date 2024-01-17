Automatic Recording Windows Script

This Windows script allow us execute a program as OBS Studio to start recording our screen and furthermore open a second program that we would like to record.

What does the script?

 - Firstly check the folder where locate the record files if exist more than 10 files, and remove the oldest.
 - Secondly, execute obs studio and start recording.
 - To minimize to background OBS Studio, we use an extended windows library that allow us to inject some commands.
     -  This library should be installed previously from: https://www.nirsoft.net/utils/nircmd.html
 - Finally we execute the .exe that we would like to record.


Pre-Requirenment
  - Install nircmd extended cmd windows library https://www.nirsoft.net/utils/nircmd.html

How to use?
  There is multiples way to execute this .bat, but we main porpuse has been designed to attend a friendly requirenmente.
  Our friend want to start recording the screen when a program is oppened. To attend this requirenment, we have done the following configuration.
    - We have created a shortcut in desktop from our bat (this will allow us change the icon and execute it directly with mouse double click)
    - We have changed the icon to simulate the icon from the program that we would like to record, in the example is used notepad++.
  
  Following this configuration, you will trigger the final program starting to recording with OBS in background, and the recording will be stopped once you close the pc.
  
  This will allow monitorize your desktop when this program is executed.
