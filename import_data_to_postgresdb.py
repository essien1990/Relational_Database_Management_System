import pandas as pd
from sqlalchemy import create_engine
import glob

engine = create_engine('postgresql://admin:admin@loalhost:5432/papers')

all_table = pd.DataFrame()

path= '/Volumes/MacBackup/DEV\ Tuts/projects/parch_posey_DB/*.xlsx'


for filename in glob.glob(path):
	df = pd.read_excel(filename)
	data_sql = df.to_sql('parchpose',engine, schema='document')
