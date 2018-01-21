# ELK-Tutorial

# Terraform/Artefacts setup
##first setup your terraform variables as below
- clone repo in to your loca machine
- cd to donwlaoded directory
- export AWS_ACCESS_KEY_ID=AKIXXXXXXXXXXXXXXXXXXXXXXXXX
- export AWS_SECRET_ACCESS_KEY=12+DQVlXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
- export TF_VAR_profile=yours
- export TF_VAR_region=eu-west-2
- export TF_VAR_key_name=yourkey
- create a bucket in eu-west-2 . give it a unique name
- run this command ```bucket_name=xxxxx && find . -name "*.tf" -exec sed -i -e "s#elk-terraform-remote-state-storage-s3#$bucket_name#g" '{}' \; ```


## setup required artefacts
- cd to  terraform/accessories and run terraform init && rerraform plan , then run terrafrom apply
- if all goes well cd to network and do the same
- next to ELK-Artefacts


## Elasticsearch and Kibana config update
- update app configuration


### Test/Sample  data 
- download https://download.elastic.co/demos/kibana/gettingstarted/shakespeare_6.0.json
- download https://download.elastic.co/demos/kibana/gettingstarted/accounts.zip
- download https://download.elastic.co/demos/kibana/gettingstarted/logs.jsonl.gz

- unzip accounts.zip
- gunzip logs.jsonl.gz
- on Elastic search host, run the following
```
curl -XPUT 'localhost:9200/shakespeare?pretty' -H 'Content-Type: application/json' -d'
{
 "mappings": {
  "doc": {
   "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "keyword"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
   }
  }
 }
}
'


curl -XPUT 'localhost:9200/logstash-2015.05.18?pretty' -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'


curl -XPUT 'localhost:9200/logstash-2015.05.19?pretty' -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'

curl -XPUT 'localhost:9200/logstash-2015.05.20?pretty' -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'
```

## upload data to Elasticsearch
- curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/bank/account/_bulk?pretty' --data-binary @accounts.json
- curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/shakespeare/doc/_bulk?pretty' --data-binary @shakespeare_6.0.json
- curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @logs.jsonl

## varify upload
- curl -XGET 'localhost:9200/_cat/indices?v&pretty'


## using kibana to view data
