local ScriptSingal = require(script.Parent.Parent:WaitForChild("Modules"):WaitForChild("MadworkScriptSignal"))

export type Replica = {
	Data: {any},
	Tags: {any},
	SetValue: (self: Replica, Path: {string}, NewValue: any) -> nil,
	SetValues: (self: Replica, Path: {string}, NewValues: {any}) -> nil,
	ArrayInsert: (self: Replica, Path: {string}, Value: any) -> number,
	ArrayRemove: (self: Replica, Path: {string}, Index: number) -> any,
	ArraySet: (self: Replica, Path: {string}, Index: number, Value: any) -> nil,
	ListenToChange: (self: Replica, Path: {string}, Listener: (newValue: any, oldValue: any) -> nil) -> typeof(ScriptSingal.NewArrayScriptConnection())
}

return nil