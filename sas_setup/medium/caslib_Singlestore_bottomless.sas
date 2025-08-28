cas;

proc cas;
    table.addCaslib / name='SPEEDCBL'
		description='S2 Bottomless Caslib '
        session=FALSE
        datasource={
            srctype='singlestore',
			aggregatePushdown=TRUE,
			database='myDB_BL',
			epDatabase='S2Work',
			host='svc-sas-singlestore-cluster-dml',
			uid='sas', 
			pwd='{SAS001}T3Jpb24xMjM='
		};
quit;

caslib _all_ assign;
