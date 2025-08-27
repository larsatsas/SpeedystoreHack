# SpeedystoreHack
Repo to hold instructions for use of Speedystore for SAS Hackathon


## Fast Analytical Queries, No More ETL Pipelines
![Overview](images/conceptual%20architecture.jpg)


## A Single Data Platform For Analytics & AI

### Benefits
* Use your data platform for your Gen AI apps
* One data platform for all use cases (Vector, SQL, NoSQL)
* Utilize existing features for Real-time data ingestion and efficient bulk load of vectors
* An enterprise platform with ACID transactions, High Availability, DR, Point in time recovery

![Overview](images/datatypes.jpg)

![Overview](images/genaietc.jpg)

## Deployment architecture

![Overview](images/deployment.jpg)


## Make Singlestore work with SAS Viya

To use Singlestore from Viya in this setup, there are a few things that needs to be configured in Singlestore; some configuration to ensure sorting is similar to SAS, setup users to access Singlestore, and databases to work with from SAS Viya. SAS Viya also need to define libname and caslib towards the database in Singlestore you want to work with.


