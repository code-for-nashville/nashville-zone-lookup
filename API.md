# API

Our `/api/landuses` endpoint accepts a [geographic point](https://developers.arcgis.com/documentation/common-data-types/geometry-objects.htm#POINT) within Nashville, and returns information on the zoning district of that point, along with a list of land use conditions.

## Parameters

| name  | type | description | example |
| -- | -- | -- | -- |
| point | int,int | A comma separated x,y value representing the geographic point | `/api/landuses?point=37.223,-23.22` |

## Response

The endpoint returns an object in the following shape:

| key | type | description |
| -- | -- | -- |
| zone | `Zone` | High level description of the zoning district of the geographic point.  See description of the `Zone` below object for more info. |
| land_uses | List of `LandUses` | A list of land uses. Each `LandUse` object also includes a `LandUseCondition` object describing the conditions under which it is permitted within the `zone` of the geographic point.  See description of the objects below for more information. |

### Objects

`Zone` - A high level description of a zoning district.

| key | type | description |
| -- | -- | -- |
| code | string | The short zoning code, e.g. "RS-80". |
| description | string | A short sentence describing the zone. |
| category | string | The category this zone falls into, e.g. "Residential" or "Industrial". |

`LandUseCondition` - A description of a constraint on a land use.

| key | type | description |
| -- | -- | -- |
| category | string | To help with representing these constraints in the UI, we categorize conditions as either `permitted`, `not_permitted`, or `conditionally_permitted`. |
| code | string | The short code for the condition, e.g. "P", "NP". |
| description | string | A short sentence describing the constraint. |
| info_link | string | A URL with more information about the constraint, e.g. https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIIUSPECOPC. |


`LandUse`

| key | type | description |
| -- | -- | -- |
| category | string | The category of land use, e.g "Educational". |
| name | string | The name of the land use, e.g. "Hospital", "Correctional Facility". |
| condition | `LandUseCondition` | An object describing the conditions under which this land use is permitted in a returned zone. |

### Example

This retrieves land use information for 307 31st Ave N., an apartment building in an RM-40 zoning district.

_Query_: `/api/landuses?address=307%2031st%20Ave%20N.`

_Response_: Note that `land_uses` is truncated to only include a few example entries - the actual response includes an entry for each land use.

```json
{
	"zone": {
		"description": "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  40 units an acre.",
		"code": "RM40",
		"category": "Residential"
	},
	"land_uses": [
		{
			"name": "Single-family",
			"condition": {
				"info_link": null,
				"description": "Permitted by right.",
				"code": "P",
				"category": "permitted"
			},
			"category": "Residential"
		},
    {
			"name": "Fraternity/sorority house",
			"condition": {
				"info_link": null,
				"description": "Permitted by right.",
				"code": "P",
				"category": "permitted"
			},
			"category": "Educational"
		},
    {
			"name": "Telephone services",
			"condition": {
				"info_link": "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIIUSPECOPC",
				"description": "Permitted subject to certain conditions.",
				"code": "PC",
				"category": "conditional"
			},
			"category": "Communication"
		}
  ]
}
```

## Internals

The API follows these these steps:

1. Lookup the zoning district code of the point using the ArcGIS zoning layer API with the following parameters:

| param | value | note |
| -- | -- | -- |
| f | "json" | return JSON formatted data. |
| geometry | x,y | the x,y value of the point. |
| geometryType | "esriGeometryPoint" | indicate that we're searching for a point. |
| returnGeometry | false | we don't want to return the shape of the zone, just the code. |
| outFields | "ZONE_DESC" | Minimal out put fields - the `ZONE_DESC` is the zone code. |
| inSR | 3857 | Web Mercator spatial reference. |
| outSR | 3857 | Web Mercator spatial reference. |

Example query and response:

_Query_: http://maps.nashville.gov/arcgis/rest/services/Zoning_Landuse/Zoning/MapServer/14/query?f=json&geometry=-9659391.4679322354,4324051.0055414531&geometryType=esriGeometryPoint&inSR=3857&returnGeometry=false&outFields=ZONE_TYPE,%20ZONE_DESC

_Response_:
```json
{
	"displayFieldName": "OBJECTID",
	"fieldAliases": {
		"ZONE_TYPE": "SP Type",
		"ZONE_DESC": "Zoning"
	},
	"fields": [
		{
			"name": "ZONE_TYPE",
			"type": "esriFieldTypeString",
			"alias": "SP Type",
			"length": 10
		},
		{
			"name": "ZONE_DESC",
			"type": "esriFieldTypeString",
			"alias": "Zoning",
			"length": 20
		}
	],
	"features": [
		{
			"attributes": {
				"ZONE_TYPE": null,
				"ZONE_DESC": "MUI"
			}
		}
	]
}
```

2. Get zone data from our `zones` table.

Example:

```sql
select
category, code, description
from zones
where code = 'MUI';
```

```
"Mixed Use",
MUI,
"Mixed-use intensive.  High intensity mixture of residential, office, personal service and retail shopping."
```

3. Get information on all the land use conditions for the zoning code from our `zone_land_use_conditions` table.

```sql
select
lu.name,
lu.category,
luc.code,
luc.category as land_use_condition_category,
luc.description,
luc.info_link
from
  zones z
  inner join zone_land_use_conditions zl on z.id = zl.zone_id
  inner join land_uses lu on zl.land_use_id = lu.id
  inner join land_use_conditions luc on zl.land_use_condition_id = luc.id
where
z.code = 'MUI';
```

4. Set the `zone` key in the returned object to information from step 2.  For each row returned in step 3, add an item to the `land_uses` key.

## Errors

The current version of the API uses HTTP status codes to represent different error cases.  A 200 is an 👌 response.

| HTTP status code | error condition |
| -- | -- |
| `404` | The point passed in doesn't match a known Nashville. |
| `422` | The address was found, but we don't have zoning or land use information available. We might be missing information if *a)* the point is in a Satellite City, like Berry Hill, or *b)* we have a gap in our land use information.  For example, if our land use doesn't include a hypothetical zone code (RS-80-Z), we could return this status. |
| `500` | An unknown internal server error occurred. |
