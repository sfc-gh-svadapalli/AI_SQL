## ⚠️ Troubleshooting & FAQ

Common errors and resolutions:


> * **Issue:** AttributeError: 'NoneType' object has no attribute 'query_scan_data_frame'
> * **Cause:** This happens when a cell in notebooks ends with a commented line of code
> * **Solution:** Remove the commented line in the code at the end of the cell



> * **Issue:** NotebookSQLException: 100351: Request failed for external function COMPLETE$V6 with remove service error: ...
> * **Cause:** This happens when the model is busy and fails after a certain amount of time has passed
> * **Solution:** try using `claude-3-sonnet` as the model or try another time as this will complete it just depends on the loads on the model
