local Radiator = {}

--[[

For tuning these settings, look up the actual measurements (using inches) and just translate them onto here.

Be realistic, and don't go stupid crazy with the values.

General tips:
 - Bigger cores are better for cooling, but think about your engine space in real life. How much space does
   this radiator take up inside the engine bay?
   
 - Generally the more rows, the better cooling (this is not always the case though, as a 2-row radiator with
   bigger cooling tubes can be better than a 3-row radiator, but cooling tube size is not simulated here)
   
 - For row count, 1-row is usually good for powersports or small car applications where not much cooling is
   required. 2-row radiators are used in most passenger car applications, and 3+ row radiators are usually
   used in heavy-duty and high performance applications.
   
 - When setting fan speed, put the value as the amount of CFM that the fan can displace but divided by 1000 (CFM/1000)

]]--

Radiator.CoreLength = 20

Radiator.CoreHeight = 20

Radiator.CoreThickness = 1

Radiator.Rows = 2

Radiator.CoolingFan = true

Radiator.FanCFM = 5 

--[[

CAR SETTINGS

Settings to change the operating temperature and the overheat temperature as well as the units displayed.

Changing the temp unit will require you to put in the correct value for that unit.

]]--

Radiator.TempUnit = "F"

Radiator.OverheatTemp = 240

Radiator.FanActivateTemp = 195
	
Radiator.OperatingTemp = 150

Radiator.AmbientTemp = 90




Radiator.DebugEnabled = false -- use this for fine tuning, only use if you know what you are doing and make sure to disable before you upload your car
							  -- !MAKE SURE TO OPEN THE OUTPUT TAB WHEN USING!

return Radiator

