cas;

proc cas;
    table.addCaslib / name='SPEEDYC'
		description='My S2 Caslib'
        session=FALSE
        datasource={
            srctype='singlestore',
			aggregatePushdown=TRUE,
			database='myDB',
			epDatabase='S2Work',
			host='svc-sas-singlestore-cluster-dml',
			uid='sas', 
			pwd='{SAS001}T3Jpb24xMjM='
		};
quit;

caslib _all_ assign;
