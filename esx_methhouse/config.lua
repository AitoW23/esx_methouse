Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 4
Config.TimerBeforeNewRob    = 5 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 7   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["grapeseed_methhouse"] = {
		position = { x = 2445.97, y = 4983.92, z = 46.81 },
		reward = math.random(5000, 10000),
		nameOfStore = "MethHouse, Sinulla täytyy olla ase aloittaaksesi ryöstön",
		secondsRemaining = 600, -- seconds
		lastRobbed = 0
	},
}
