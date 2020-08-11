-- A gateway is consider disconnected if any of these conditions is met:
--    * It hasn't sent a package for more than 5 minutes
--    * It hasn't sent a package for more than 1 minute and more than 10 times it's usual frequency
UPDATE public.gateway
SET connected = false, activity_freq = 0
WHERE connected AND (last_activity + CONCAT(LEAST(300, GREATEST(60, COALESCE(activity_freq, 0)*10))::text, ' seconds')::interval) < now()

-- A device is consider disconnected if any of these conditions is met:
--    * It hasn't sent a package for more than 10 minutes
--    * It hasn't sent a package for more than 2 minutes and more than 20 times it's usual frequency
UPDATE public.device
SET connected = false, activity_freq = 0
WHERE connected AND (last_activity + CONCAT(LEAST(600, GREATEST(120, COALESCE(activity_freq, 0)*20))::text, ' seconds')::interval) < now()