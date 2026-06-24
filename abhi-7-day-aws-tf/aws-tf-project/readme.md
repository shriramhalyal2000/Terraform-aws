This is  a poc on aws concepts exeuted through tf 
>> although tutorial follows hardcoding of values but this poc follows module format for cleaner code
   the env dir has main, var, output, locals, no backend becuase its initiated and configured in module
   module has its own main, output, and backend, main.tf has module vpc with source as ../env