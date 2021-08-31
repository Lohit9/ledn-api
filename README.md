# Ledn Token Interview Challenge

## About
A GraphQL API build in Ruby, using the Rails framework. The application is intended to be used to request Account Holder data. In addition to requesting Account Holder data from the provided JSON data, it provides the ability to sort and filter data.

In the effort to keep the application lean, no external libraries have been used (besides the default functionality provided by GraphQL, GraphIQL and Rails). 

The API has been deployed using Heroku and can be accessed here - https://ledn-api.herokuapp.com/graphiql 

## Local setup 
If you would like to run the app on your local machine, here are the instructions: 
 1. Download the repo 
 2. App uses v'2.6.8' or Ruby and  v6.1.4.1 of Rails. Please ensure your machine is compatible with these.
 3. Execute `bundle install` in order to install the dependencies (ex: GraphQL, GraphIQL, etc) 
 4. Configure the PostgreSQL DB by setting it up in the database config file (config/database.yml) and executing `rake db:create` to setup the local database.
 5. You should now be able to execute the server by runnin `rails s` and you can view the GraphQL interface by accessing the `/graphql` route (ex: http://localhost:3000/graphiql) 

## Usage 
#### General:
This query would retrieve data from all the accounts we have in the database. 
```
query {
  accounts{
    firstName
    lastName
    email
    amt
    country
    mfa 
    createdDate
    dob
    referredBy
  }
}
```

#### Filtering:
API allows filtering by `firstName`, `lastName`, `country` and `mfa`. The following is an example query that retrieves all the users with the first name "Emily", based in Canada and have chosen SMS a mode of MFA. 
```
query {
  accounts(firstName:"Emily", country: "CA", mfa: "SMS"){
    firstName
    lastName
    email
    amt
    country
    mfa 
    createdDate
    dob
    referredBy
  }
}
```

#### Sorting:
API allows sorting by the amount of tokens held and the account creation date. The following query would sort all accounts in our database by the increasing order of the amount of tokens held. Other sorting options available are: `amtDesc`, `createdDateAsc` and `createdDateDesc`. 
```
query {
  accounts(sort:[amtAsc]){
    firstName
    lastName
    email
    amt
    country
    mfa 
    createdDate
    dob
    referredBy
  }
}
```


## Future development
Due to the limited time I was able to spend building the API, here are some things that I would like to spend time building next:
* Developing a test suite for the GraphQL API 
* Implement post request caching (at the server level) - a use case for partially/fully caching the response from a request would be that it would reduce response time when the same filters/sorting params are used but the user is interested in specific params. For example:

First query executed by the user: 
```
query {
  accounts(country: "CA", sort: [createdDateDesc]){
    firstName
    lastName
    amt
    mfa
  }
}
```  
If we were to cache the result of this query, any future queries with the same query arguments (i.e `country: "CA", sort: [createdDateDesc]`) but varying params(ex: country, amt, etc) would be a magnitude faster (especially as the size of the dataset grows). 
* Index columns being queried often, together (ex: `first_name` and `last_name`) - The filtering functionality is implemented by string comparison of the supplied argument and the values from the Database. We would benefit when scaling the dataset if we are able to index columns together and this would reduce the number of DB queries.
* Spend time investigating if there is an efficient alternative to `ILIKE` operation when filtering - For the filtering functionality we make a query such as: `first_name ILIKE ? Joe`. `ILIKE` was chose over normal string comparison so as to ensure we're able to include results that are a partial match to the user provided argument (in addition to ensuring the comparison is case insensitive). 
* Work on implementing a more efficient way to seed the database from the input JSON file - some options are to load the file input-stream in chunks to reduce in memory usage while seeding the DB. In addition, we can also parallelize the loading of data if we load the file in chunks. 
