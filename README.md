# BatchUtilities
Set of batch scripts ready to be used at Command Prompt.

* [Automatic tests](#TOC_Automatic_tests)

* [Batch scripts](#TOC_Batch_scripts)
  * [HowLong.bat](#TOC_HowLong)
  * [Log.bat](#TOC_Log)
  * [LogSetFile.bat](#TOC_LogSetFile)
  * [LogSetLevel.bat](#TOC_LogSetLevel)
  * [Menu.bat](#TOC_Menu)
  * [Sleep.bat](#TOC_Sleep)



<a id="TOC_Automatic_tests"></a>Automatic tests
================================================================================

Test are prepared for following scripts:

* HowLong.bat
* Menu.bat
* SelectDirectory.bat
* SelectFile.bat
* Sleep.bat

Following tests are not yet ready:

* CreateShortcut.bat
* Kill.bat
* Run.bat



Following scripts are unable to test automatically

* Log.bat


<a id="TOC_Batch_scripts"></a>Batch scripts
================================================================================


<a id="TOC_HowLong"><hr /></a>

## HowLong.bat
--------------------------------------------------------------------------------


### Description
Run application or a script calculating real time used by it. It dsiplays
used time in human readable format.


### Parameters
Command and its parameters required to run.


### Known limitations


### Depends
[FormatTime.bat](#TOC_FormatTime)
[TimeDiff.bat](#TOC_TimeDiff)


### Returns
ERRORLEVEL    - Number of hundredths of a second.



<a id="TOC_Log"><hr /></a>

## Log.bat
--------------------------------------------------------------------------------


### Description
Simple log utility.

If current log level is not configured with [LogSetLevel.bat](#TOC_LogSetLevel)
or is configured to ALL then all parameters are displayed to standrad output.

If current log level is configured to one of values: CRITICAL, ERROR, WARNING, 
INFO, TRACE, DEBUG, then first parameter of Log.bat is treated as a message log
level. Other parameters are displayed when message log level is less or equal
to current log level.

If Log File Name is configured with [LogSetFile.bat](#TOC_LogSetFile) then Log.bat output is also
appended to configured log file.


### Parameters
If Current Log Level is ALL
1. ... - Log Message composed from all parameters is always displayed.

For all other values of Current Log Level
1. Message Level: CRITICAL, ERROR, WARNING, INFO, TRACE, DEBUG
2. ... - Log Message composed from all parameters except first is displayed if 
    Message Level <= Current Log Level


### Known limitations
- If any of Log Message parameters contains one of following characters space( ), tab( ),
comma(,), semicolon(;), or equal sign(=) then the parameter have to be surrounded with
double quotes.
- The message parameters can not contain double quotes, unles used to surround the 
parameter. Double quotes will not be displayed.

### Depends


### Returns
None.



<a id="TOC_LogSetFile"><hr /></a>

## LogSetFile.bat
--------------------------------------------------------------------------------


### Description
Configure Log File Name to be used by [Log.bat](#TOC_Log).


### Parameters
1. Possible values:
    - Empty. Display currently configured Log File Name.
    - file name - File name to be used as Log File Name.
    - OFF - Disable logging to file.


### Known limitations


### Depends


### Returns
None.



<a id="TOC_LogSetLevel"><hr /></a>

## LogSetLevel.bat
--------------------------------------------------------------------------------


### Description
Configure Current Log Level to be used by [Log.bat](#TOC_Log).


### Parameters
1. Possible values:
    - Empty. Display currently configured Current Log Level.
    - New Current Log Level value:
        - ALL - All Log Messages are displayed,
        - CRITICAL - only CRITICAL Log Messages are displayed,
        - ERROR - only CRITICAL and ERROR Log Messages are displayed,
        - WARNING - only CRITICAL, ERROR, and WARNING Log Messages are displayed,
        - INFO - only CRITICAL, ERROR, WARNING, and INFO Log Messages are displayed,
        - TRACE - only CRITICAL, ERROR, WARNING, INFO, and TRACE Log Messages are 
                  displayed,
        - DEBUG - All Log Messages are displayed.


### Known limitations

### Depends


### Returns
None.



<a id="TOC_Menu"><hr /></a>

## Menu.bat
--------------------------------------------------------------------------------


### Description
Script used to initialize, build, run and clear simple text menu.


### Parameters
1. Operation to exec by the script:
    - Init - Initialize menu

        - 2. Name of temporary menu file.
        - 3. Unique ASCII character, not present in menu items and values.
             This is optional parameter. default value is "|".
    - AddItem - Add single item to menu.

        - 2. Name of temporary menu file.
        - 3. Item value to be returned when item selected in menu.
        - 4. Item description to be displayed in menu. Optional,
             If not present then identical to item value.
    - Select - Run menu, and select one of menu items.

        - 2. Result variable name.
        - 3. Name of temporary menu file.
        - 4. Message
    - Clear - Delete all temporary files created during initialization.

        - 2. Name of temporary menu file.

### Known limitations


### Depends


### Returns
Selected item value in result variable.





