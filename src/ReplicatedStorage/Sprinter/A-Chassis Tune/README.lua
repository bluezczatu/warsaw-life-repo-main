--[[	Please, do not delete this module.
	   ___  _____
	  / _ |/ ___/	Avxnturador | Novena
	 / __ / /__			 LuaInt | Novena
	/_/ |_\___/   Build 6C, Version 1.5, Update 1
						
		Special thanks to DJay500, HAYASHl, IMeanBiz, Zyori, BobNoobington, and to all of the beta testers and bug reporters. 

The "A-Chassis Tune" module is where you would want to go to tune the car. Everything you'd need to touch would be there.
		 _______________________________________________________________________________
		|																				|
		| It is highly recommended to completely re-install A-Chassis 6 C from scratch.	|
		|_______________________________________________________________________________|
		
		Upgrade instructions from 1.3 are not available due to the numerous updates and additions. 
		We apologize for the inconvenience.

--AC6 C Changelog
[02/01/21 : A-Chassis C Version 1.5, Update 2] - DO People Read These?
	[Misc.] -LuaInt
		- Weight brick density cap added
		- Rear caster fixed
		- Aerodynamics fixed
		- Engine and induction sounds fixed

[12/31/20 : A-Chassis C Version 1.5, Update 1] - The Movement Update 2, The Reckoning
		[Overhaul] -LuaInt
			- Weight calculation entirely rewritten
			- Torque delivery calculation simplified, engine untouched
			
		[New Suspension System] -LuaInt
			- In-depth player-built suspension (Tutorial can be found on our Discord: https://discord.gg/VuR3jkuGYE )
			- Chassis contains double-wishbone suspension on all 4 wheels by default
			- Deleting the "SuspensionGeometry" model inside of a wheel will revert it to pre-1.5 suspension
			
		[Plugins] -LuaInt
			- New aerodynamics plugin
			- New stock engine and exhaust sound plugin
			- New forced induction sound plugin
			
		[Miscellaneous] -LuaInt
			- Tune reorganized

[07/09/20 : A-Chassis C Version 1.4, Update 4] - The Burnout Update
		[Welding Bugfix] -Avxnturador and LuaInt
			- Fixed a parenting issue in the Initialize script regarding welds, making client and server replication break.
			
		[Parking Brake Bias] -Avxnturador
			- Added Parking Brake Bias, works like regular Brake Bias
			
		[Four Wheel Steering Update] -LuaInt
			- Updated Static 4WS as part of a bugfix.
			
[06/19/20 : A-Chassis C Version 1.4, Update 3] - The Braking Bugfix
		[Updated Parking Brake] -LuaInt
			- Updated Parking Brake for simplicity in the Drive
			- Also fixes a bug where all 4 wheels have the parking brake applied

[06/14/20 : A-Chassis C Version 1.4, Updates 1 and 2] - The Movement Update
		[Pertaining to Update 2] -LuaInt and Avxnturador
			- Separated Front and Rear Steering gyro options (Added Tune.RSteerD, Tune.RSteerMaxTorque and Tune.RSteerP)
			- Added rear wheel steering to "R" wheels
				Please add Tune.RSteerD, Tune.RSteerMaxTorque and Tune.RSteerP to the tune to take advantage of separated gryo options

		(Personal Note by Avxnturador)
			This update would not have been as big of an update without LuaInt
			With that said, LuaInt is now the newest member to the AC6 and NCT chassis team.
			Thank him endlessly.
			
		[New Engine] -Avxnturador 
			- Combining AC6C V1.2's engines alongside AC6C V1.3's aspiration, the engine now has its final revision
			- Instructions to tune it are now similar to both previous versions of the chassis', and a new Desmos graph reflects it
		
		[PGS Physics Overhaul] -LuaInt
			- The chassis now uses PGS Physics Solver Components to replace the legacy BodyMovers
			- Different Power and Brake motors are now implemented, bringing a more realistic driving experience
			
		[Rev Limiter] -Avxnturador
			- Limits the RPM to a certain set RPM
			- Can be limited in Neutral gear or when the clutch is in
		
		[New Steering] -LuaInt
			- More realistic steering options
			- Ackermann steering included for more true-to-life steering
		
		[Four Wheel Steering] -LuaInt
			- If activated, the rear wheels will turn alongside and/or against the front wheels
			- Check the Tune to see how to tune it
			- Note: Always have the rear wheels' degrees (e.g. 12, 15) LESS THAN the front wheels (e.g. 37, 45)
		
		[New Differential] -LuaInt
			- The new differential is easier to understand and tune
			- Includes power, coast, and preload
		
		[Clutch Kick] -LuaInt
			- Torque will be multiplied if a clutck kick occurs
			- Helpful for getting extra power to drift or get up hills
		
		[Braking Overhaul] -LuaInt
			- Braking has been combined, alongside with brake bias
			- Engine braking has also been introduced
		
		[Suspension Geometry Separation] -Avxnturador
			- The suspension geometry (the wishbone and spring) can now be separated
			- This is done with the new Spring Offset values
			- This will move the spring offset IN RELATION TO THE ANCHOR OFFSET

		[Weight Optimization] -Avxnturador
			- Objects with the Massless property enabled will be ignored when calculating weight
			- This is insanely helpful for highly detailed cars where the cars' mass would reach excess of 1000 or so

		[Others] -Avxnturador
			- Revamped the Auto Update feature to be better alongside the new model
			- Removed the Drag feature, allowing third-party plugins to handle that force by itself
			- Added RCaster for four wheel steering enabled cars 
		
		[Legacy Physics Deprecated] -LuaInt and Avxnturador
			- With the release of this new chassis, Legacy physics engine support has been completely deprecated
		
	[09/18/19 : A-Chassis C Version 1.3, Update 1] - The Engine Update
		[Engine]
			-The engine from the NCT: M chassis has been carried over
			-This allows for great control over your power graphs
			-This also separates aspiration, allowing for twincharging and unlimited aspiration objects
		
		[Backwards Compatibility]
			-If you don't want to retune your engine, backwards compatibility has been brought over
			-You can use your AC6C V1.2 engine tune with this update
			-Take a look at #ENGINE to look at engine backwards compatibility
			-YOU MUST UPDATE THE WHOLE ENGINE CODE IN THE TUNE, #ENGINE WILL THEN OVERRIDE THAT CODE!
		
		[Clutch]
			-Added three different clutch types, all under Tune.ClutchType
				-Clutch, standard clutch present in AC6C
				-Torque Converter, keeps RPM up overall
				-CVT (however not a true CVT), keeps RPM at a set RPM until above
		
		[Other]
			-Added Tune.Drag, simulating drag right from the chassis
			-Added throttle and brake responsiveness
				-Tune.ThrotAccel and Tune.ThrotDecel
				-Tune.BrakeAccel and Tune.BrakeDecel
			
			-Fixed auto-updating feature, PLEASE update or reinstall this chassis to your cars.
	
	[05/28/19, 05/30/19 and 07/31/19 : A-Chassis C Version 1.2, Updates 3, 4 and 5] - The Optimization Update
		[Bugfixes]
			-Added delta time so the chassis runs smooth at any framerate
				-RPM, steering, and power all contain these fixes.
				-The clutch, due to its' nature, is not optimized, however it should still be good.
			-Fixed curve caching so HP and Torque don't jump from one value to the other
			-Fixed a typo that disallowed electric motors to rev (yes, really)
			-Fixed boost intakes so they cut off once throttle is cut off (mainly in shifting)
		
		To install, please replace the Drive script, and update the "Version" value to 5.
	
	[04/28/19 : A-Chassis C Version 1.2, Update 2] - The Rev Update
		[Bugfixes]
			-I literally just made it so revving with clutch off felt like old A-Chassis.
			-That's it. It's just so it revs like it should.
	
	[04/16/19 : A-Chassis C Version 1.2, Update 1] - The Transmission and Future-Proof Update 
		[Clutch]
			-After having a very rough start and notoriety, a newer clutch system has been added. 
			-Torque should now be fixed, tune revision from previous versions highly recommended.
			-Special thanks to IMeanBiz, the creator of the newly-revised clutch.
				Note: PLEASE DO NOT SEND TRANSMISSION QUESTIONS TO HIM! Send them to Avxnturador instead.
			-Tune.Clutch has been added, disabling it makes the chassis act like AC6.81T (no realistic clutch).
			-Tune.ClutchMode has been added, changes if RPM will influence the clutch or not.
		
		[Transmission Changes]
			-Automatic shifting has been revamped, making it fail-safe.
			-Automatic shifting settings has been expanded on.
				-Automatic shifting mode, toggle between Speed and RPM
				-Automatic shifting type, toggle between DCT (AC6.81T) and Rev (AC6C V1)
				-Automatic shifting version, toggle between Old (AC6.52S2) and New (AC6.81T)
			-Old "Shift Time" shifting behavior is reintroduced under "DCT".
			-Revmatching is modified, values for throttle behavior introduced.
		
		[Automatic Updates]
			-In an attempt to heavily reduce bugfix releases, an auto updater has been added.
			-You are heavily advised to take a copy of this chassis if you haven't already.
			-Minor bugfixes will automatically be installed, while major updates will not.
			-You will be notified of any update, minor or major. 
			-You can opt out of this by changing "Tune.AutoUpdate" to false.
		
		[Tune Changes]
			-A completely new Transmission tune panel, check the values inside for more information.
	
	[12/09/18 : A-Chassis C Version 1.1] - The Refinement Update
		[Drive Changes]
			-Manual transmission gearshifts now work properly.
			-Downshift revmatching has been implemented.
			-The clutch is now smooth when the clutch is disengaged. Only works and makes sense in Manual transmissions.
		
		[Tune Changes]
			-Added "Tune.ClutchSens", Clutch Sensitivity. 
			-Added "Tune.Stall", the ability to stall. 
		
		[Plugin Changes]
			-Added "AC6C_Ignition", a stock ignition switch. "F" is the key to start/stop the engine.
		
		[Note]
			-To stop stalling at low RPM's, most noted in first gear, engage the clutch around where Idle RPM is set right before you come to a stop.
		
		[Planned future updates]
			-New, more efficient sound scripts. Thanks to lsThisThingOn for the idea of replacing the scripts for something better.
	
	[12/02/18 : A-Chassis C Version 1.0] - The Anniversary Update
		[Clutch]
			-With a humongous thanks to DJay500, the newest member to Novena, a proper clutch has been added. 
		
		[Drive Changes]
			-A new clutch system has been added, along with new RPM calculations.
			-The gear system has been reworked. Upshift revmatching is now implemented.
		
		[Tune Changes]
			-Changed "Tune.ClutchTol" to "Tune.Flywheel"
			-Added "Tune.ClutchMult", Clutch Multilpier.
		
		[Plugin Changes]
			-Changed the stock gauges to include options to change the clutch input.
			-The white button will allow you to change the clutch amount. Full white bar means clutch engaged, no white bar means clutch disengaged.
		
		[Planned future updates]
			-Stalling is planned, a stock ignition plugin would be included if so.
			-Downshift revmatching is planned to complement everything else.
--]]

return "1.5"