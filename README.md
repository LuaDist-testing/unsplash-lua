# Unsplash Lua (Unofficial)

A Lua package for the [Unsplash API](https://unsplash.com/developers). Current version only supports [public actions](https://unsplash.com/documentation#public-actions).

# Documentation
* [Installation](#installation)
* [Dependencies](#dependencies)
* [Requiring](#requiring)
* [License](#license)
* [Reference](#reference)
* [TODOs](#todos)
* [Shoutout](#shoutout)
* [License](#license)

# Installation
Install unsplash-lua and it's dependencies.
```bash
$ luarocks install unsplash-lua
```

# Dependencies
This package depends on [luasec](https://github.com/brunoos/luasec) and [luasockets](https://github.com/diegonehab/luasocket). The installation via luarocks
should handle these. If not check your installation for errors.

# Requiring
To use the package simply require it and spawn a new instance, providing your application ID given to you during your [app registration](https://unsplash.com/documentation#registering-your-application).

```lua
local Unsplash = require 'unsplash-lua'

--
local unsplash = Unsplash.new({
  applicationId = 'YOUR_APPLICATION_ID_HERE'
})
```

# Reference
TODO: link all the things here
## Methods
Every request returns a table with four fields in it and is preceeded by ```unsplash.```i.e :

```lua
response = unsplash.stats.total()
```

### Reponse table fields
| Field       | Type     |
| :------------- | :------- |
| response.body  | String   |
| response.header| Table    |
| response.code  | Number   |
| response.status| String   |

### Error handling

If an error occurs, whether on the server or client side, the error message(s) will be returned in an string (response.body). For example:
```
422 Unprocessable Entity
```
For legibility purposes, the string is formatted in JSON:
```json
{
  "errors": ["Username is missing", "Password cannot be blank"]
}
```

## Category
### category.listCategories()
List all categories
* Parameters
  * N/A
* Example
```lua
res = unsplash.category.listCategories()
```

### category.category(table)
Retrieves a single category
* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | Number         | Required     |


* Example
```lua
res = unsplash.category.category{id = 2}
```

### category.categoryPhotos(table)
Retrieves photos from a single category
* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | Number         | Required     |
| table.page     | Number         | Optional; Defaults to: ```1```   |
| table.per_page | Number         | Optional; Defaults to: ```10 ```   |

* Example
```lua
res = unsplash.category.categoryPhotos{id = 2,page = 10,per_page = 30}
```

## Collections
### collections.listCollections(table)
Get a single page from the list of all collections.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.page     | Number         | Optional; Default ```1```     |
| table.per_page | Number         | Optional; Default ```10```     |
| table.type     | String         | Optional; Accepts values ```featured```, ```curated```,```regular```. Defaults to: ```regular```   |

* Example
```lua
res = unsplash.collections.listCollections{} -- type = "regular", page = 1, per_page = 10
res = unsplash.collections.listCollections{page = 2,per_page = 30} -- type="regular"
res = unsplash.collections.listCollections{type = "featured", page = 1, per_page = 30}
res = unsplash.collections.listCollections{type = "curated"}
```

### collections.getCollection(table)
Retrieves a single regular or curated collection. To view a user’s private collections, the ```read_collections``` scope is required.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | Number         | Required     |
| table.type     | string        | Optional; Accepts values ```curated```,```regular```. Defaults to: ```regular```   |

* Example

```lua
res = unsplash.collections.getCollection{} -- Error, No ID
res = unsplash.collections.getCollection{id = 296} -- type = "regular"
res = unsplash.collections.getCollection{id = 146, type = "curated"}
```

### collections.getCollectionPhotos(table)
Retrieve photos from a regular or curated collection.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | Number         | Required     |
| table.page     | Number         | Optional; Default ```1```     |
| table.per_page | Number         | Optional; Default ```10```     |
| table.type     | string        | Optional; Accepts values ```curated```,```regular```. Defaults to: ```regular```   |

* Example

```lua
res = unsplash.collections.getCollectionPhotos{id = 937724}
res = unsplash.collections.getCollectionPhotos{id = 140,type = "curated"}
```

### collections.listRelatedCollection(table)
Retrieve a list of collections related to this one.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | Number         | Required     |

* Example

```lua
res = unsplash.collections.listRelatedCollection{id = 937724}
```

## Photos
### photos.listPhotos(table)

Get a single page from the list of all regular or curated photos.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.curated  | Boolean        | Optional     |
| table.page     | Number         | Optional     |
| table.per_page | Number         | Optional     |
| table.order_by | String         | Optional. Accepts values ```latest```, ```oldest```, ```popular```; Defaults to: ```latest```)  |


* Example
```lua
res = unsplash.collections.listPhotos{}
```

### photos.getPhoto(table)

Retrieve a single photo.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | String         | Required     |
| table.width    | Number         | Optional     |
| table.height   | Number         | Optional     |

* Example
```lua
res = unsplash.photos.getPhoto{id = "L-2p8fapOA8", width = 1920, height = 1200}
```

### photos.getRandomPhoto(table)
Retrieve a single random photo, given optional filters. All fields are optional, and can be combined to narrow the pool of photos from which a random one will be chosen.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
|__`width`__|_number_|Optional|
|__`height`__|_number_|Optional|
|__`query`__|_string_|Optional|
|__`username`__|_string_|Optional|
|__`featured`__|_boolean_|Optional|
|__`collections`__|_Array<number>_|Optional|
|__`count`__|_string_|Optional|

* Example
```lua
res = unsplash.photos.getRandomPhoto()
res = unsplash.photos.getRandomPhoto{username = "spacingnix"}
```

### photos.getPhotoStats(id)
Retrieve total number of downloads, views and likes of a single photo, as well as the historical breakdown of these stats in a specific timeframe (default is 30 days).

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | String         | Required     |

* Example
```lua
res = unsplash.photos.getPhotoStats("mtNweauBsMQ")
```


### photos.getPhotoDownloadLink
Retrieve a single photo’s download link.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.id       | String         | Required     |

* Example
```lua
res = unsplash.photos.getPhotoDownloadLink("mtNweauBsMQ")
```

## Search
### search.photos(table)
Get a single page of photo results for a query.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.query    | String         | Required     |
| table.page     | Number         | Optional     |
| table.per_page | Number         | Optional     |
| table.collections| Table (Array table)| Optional. Collection ID(‘s) to narrow search. If multiple, comma-separated.|

* Example

```lua
res = unsplash.search.photos{query = "love"}
res = unsplash.search.photos{
  query = "snow",
  collections = {187159}
}
```

### search.collections(table)
Get a list of collections matching the keyword.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.query    | String         | Required     |
| table.page     | Number         | Optional     |
| table.per_page | Number         | Optional     |

* Example
```lua
res = unsplash.search.collections{query = "countryside"}
```

### search.users(table)
Get a list of users matching the keyword.

* Parameters

| Argument       | Type           | Opt/Required |
| :------------- | :------------- | :----------- |
| table.query    | String         | Required     |
| table.page     | Number         | Optional     |
| table.per_page | Number         | Optional     |

* Example
```lua
res = unsplash.search.users{query = "amanda"}
```

## Stats
### stats.total()
Get a list of download counts for all of Unsplash.

* Parameters

N/A

* Example
```lua
res = unsplash.stats.total()
```

## Users
### users.getUser(table)
Retrieve public details on a given user.

* Parameters

| Argument        | Type           | Opt/Required |
| :-------------  | :------------- | :----------- |
| table.username  | String         | Required     |
| table.width     | Number         | Optional     |
| table.height    | Number         | Optional     |

* Example

```lua
res = unsplash.user.getUser{username = "matheusferrero"}
```

### users.getUserPortfolio(username)
Retrieve a single user’s portfolio link.


* Parameters

| Argument        | Type           | Opt/Required |
| :-------------  | :------------- | :----------- |
| username        | String         | Required     |


* Example

```lua
res = unsplash.user.getUser{username = "matheusferrero"}
```

### users.listUserPhotos(table)
Retrieve a single user’s portfolio link.

* Parameters

| Argument        | Type           | Opt/Required |
| :-------------  | :------------- | :----------- |
| table.username  | String         | Required     |
| table.page      | Number         | Optional     |
| table.per_page  | Number         | Optional     |
| table.stats     | Boolean        | Optional     |
| table.resolution| String         | Optional     |
| table.quantity  | Number         | Optional     |

* Example

```lua
res = unsplash.user.listUserPhotos{
  username = "philippcamera",
  stats = true
}
```

### users.listUserLikes(table)
Get a list of photos liked by a user.

* Parameters

| Argument        | Type           | Opt/Required |
| :-------------  | :------------- | :----------- |
| table.username  | String         | Required     |
| table.page      | Number         | Optional     |
| table.per_page  | Number         | Optional     |
| table.order_by | String         | Optional. Accepts values ```latest```, ```oldest```, ```popular```; Defaults to: ```latest```)  |

* Example
```lua
res = unsplash.user.listUserLikes{username = "spacingnix"}
```

### users.listUserCollections(table)
Get a list of photos liked by a user.

* Parameters

| Argument        | Type           | Opt/Required |
| :-------------  | :------------- | :----------- |
| table.username  | String         | Required     |
| table.page      | Number         | Optional     |
| table.per_page  | Number         | Optional     |

* Example
```lua
res = unsplash.user.listUserCollections{username = "spacingnix"}
```

### users.getUserStats(table)
Retrieve the consolidated number of downloads, views and likes of all user’s photos, as well as the historical breakdown and average of these stats in a specific timeframe (default is 30 days).

* Parameters

| Argument        | Type           | Opt/Required |
| :-------------  | :------------- | :----------- |
| table.username  | String         | Required     |
| table.resolution| String         | Optional     |
| table.quantity | Number           | Optional     |

Currently, the only resolution param supported is “days”. The quantity param can be any number between 1 and 30.

* Example

```lua
res = unsplash.user.getUserStats{username = "philippcamera"}
```
# TODOs
* Implement Oauth2
* Implement methods that require authorization

# Shoutout
Thanks for Unplash for starting something awesome (also documentation!)

# License
MIT License

Copyright (c) 2017 Victor Carvalho

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
