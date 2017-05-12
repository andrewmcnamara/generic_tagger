# README

This application is a Generic Tagging JSON API that can store, retrieve, delete and report on the usage of a "tag" across different entities.

## Installation

bundle install

## Running

bundle exec rails s 

## Running Tests

bundle exec rspec


## API

### Create an Entry

```
POST /tag

- Entity Type, e.g. 'Product', 'Article'
- Entity Identifier, e.g. '1234', '582b5530-6cdb-11e4-9803-0800200c9a66'
- Tags, e.g. ['Large', 'Pink', 'Bike']

If the entity already exists it should replace it and all tags, not append to it
```

### Retrieve an Entry

```
GET /tags/:entity_id

- should return a JSON representation of the entity and the tags it has assigned
```

### Remove an Entry

```
DELETE /tags/:entity_id

Completely removes the entity and tags
```

### Retrieve Stats about all Tags

```
GET /stats

Retrieves statistics about all tags

e.g. [{tag: 'Bike', count: 5}, {tag: 'Pink', count: 3}]
```

### Retrieve Stats about a specific Entity

```
GET /stats/:entity_id

Retrieves statistics about a specific tagged entity
```


## Solution Design

The approach taken to building a generic tagging JSON API, was to write the simplest code that could work. 

For saving tag information relating to entities, this solution utilises a simple join table that links tags to entities. The use of an array column type for tags was a consideration.  
However as tag usage was a requirement, the use of a join table provided simple way to get the stats for all tags, by using a simple count. 

Additionally some subtle changes have been made to the entity management api, specifically the removal of the entity type from the path, as providing the id was enough to identify the entity. 


## Limitations

- If a tag exists with a different spelling/case it creates a new tag
- Stats Endpoint for entities has not been completed - need more information on expected response 
- Testing covers just enough to prove solution works.


