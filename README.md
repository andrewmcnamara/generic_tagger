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


This solution utilises a simple join table that links tags to entities. The use of join table has the added benefit of 
providing simple way to get the stats for all tags, by using a simple count. 

For the entity management api the  has been removed from the path, as providing the id was enough to identify the entity. 


## Limitations

- If a tag exists with a different spelling/case it creates a new tag
- Stats Endpoint for entity has not been completed - need more information on expected response 
- Testing covers just enough to prove solution works.


