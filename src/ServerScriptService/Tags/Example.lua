return {
	tagName = "Bankomat",

	onInstanceAdded = function(instance: Instance): () -> ()
		return function()
			-- TODO: tutaj jak sie tag usunie to sie wykona  (cleanup)
		end
	end,
}
