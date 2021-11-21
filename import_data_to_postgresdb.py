import pandas as pd
from sqlalchemy import create_engine


# Postgresql database connection 
engine = create_engine('postgresql://username:password@host:port/databasename')

# data to import to database
path = {'accounts':'drivepath/accounts.xlsx',
	'orders':'path/orders.xlsx',
	'region':'drivepath/region.xlsx',
	'salesreps':'drivepath/sales_reps.xlsx',
	'webevents':'drivepath/web_events.xlsx'
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

	
