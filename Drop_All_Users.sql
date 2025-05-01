select '
drop user '+name+';'
from sys.sysusers where (altuid!=1 or altuid is null)
and name not in 
('dbo','guest','INFORMATION_SCHEMA','sys','omsproddeploy')

