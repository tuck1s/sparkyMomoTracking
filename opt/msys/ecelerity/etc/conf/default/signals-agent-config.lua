local cfg = {}

-- to add more custom headers it would look like this
-- custom_header = { ["X-SP-SUBACCOUNT-ID"] = "subaccount_id", ["X-CUSTOM-HEADER"] = "custom1", ["X-CUSTOM-HEADER2"] = "custom2"}
cfg.custom_header = { ["X-SP-SUBACCOUNT-ID"] = "subaccount_id", ["X-Job"] = "campaign_id" }
-- set to true if you are using your own click tracking
cfg.click = false
-- set to true if you are using your own open tracking
cfg.open = false

return cfg