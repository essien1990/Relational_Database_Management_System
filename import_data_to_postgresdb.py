
import pandas as pd
from sqlalchemy import create_engine


# Postgres database connection 
engine = create_engine('postgresql://admin:admin@localhost:5432/papers')

# data to import to database
path = {'accounts':'/Volumes/MacBackup/DEV_Tuts/projects/parch_posey_DB/accounts.xlsx',
		'orders':'/Volumes/MacBackup/DEV_Tuts/projects/parch_posey_DB/orders.xlsx',
		'region':'/Volumes/MacBackup/DEV_Tuts/projects/parch_posey_DB/region.xlsx',
		'salesreps':'/Volumes/MacBackup/DEV_Tuts/projects/parch_posey_DB/sales_reps.xlsx',
		'webevents':'/Volumes/MacBackup/DEV_Tuts/projects/parch_posey_DB/web_events.xlsx'
		}

# loop through table name and path and import to database
for tableName,datapath in path.items():
	try:
		# read excel using pandas
		df = pd.read_excel(datapath, index_col=None)
		# convert excel data to sql
		df.to_sql(f'{tableName}',engine,schema='document', if_exists='replace',index=False, index_label=None)
		print(f'Table name {tableName} has been created in the database successfully')
	except:
		print(f'Table name {tableName} cannot be created in database')

	