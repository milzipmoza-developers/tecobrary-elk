#!/bin/bash

for i in {30..0}; do
  echo "[elasticsearch-mapping-init] Checking Elasticsearch is Started..."
  echo ""
  curl -s -o /dev/null es-elk:9200
  if  [ "$?" != "7" ] && [ $(curl -fsSL "http://es-elk:9200/_cat/health?h=status" | grep -E '^green') ]; then
    echo "--------------------------------------------------------"
    echo ""
    echo "[elasticsearch-mapping-init] Elasticsearch is Started!"
    echo "[elasticsearch-mapping-init] Checking Librarybook Index Exists..."
    echo ""
    if [ $(curl -s -o /dev/null -w "%{http_code}" -I es-elk:9200/librarybooks) -eq 404 ]; then
      echo "[elasticsearch-mapping-init] Librarybooks Index Not Exist!"
      echo "[elasticsearch-mapping-init] Create Librarybooks Index"
      curl -s -o /dev/null -XPUT es-elk:9200/librarybooks -H 'Content-Type: application/json' -d '
              {
                "settings": {
                  "number_of_shards": 1,
                  "number_of_replicas": 0,
                  "analysis": {
                    "tokenizer" : {
                      "ngram_tokenizer" : {
                        "type" : "edgeNGram",
                        "min_gram" : "1",
                        "max_gram" : "30",
                        "token_chars": ["letter", "digit"]
                      }
                    },
                    "filter" : {
                      "hangul-chosung-filter" : {
                        "type" : "hangul_chosung",
                        "name": "chosung"
                      }
                    },
                    "analyzer": {
                      "nori": {
                        "tokenizer": "nori_tokenizer"
                      },
                      "hangul_chosung_analyzer": {
                        "type": "custom",
                        "filter": ["hangul_chosung"],
                        "tokenizer": "ngram_tokenizer"
                      }
                    }
                  }
                },
                "mappings": {
                  "properties": {
                    "image": {
                      "type": "keyword"
                    },
                    "title": {
                      "type": "keyword",
                      "fields": {
                        "nori_analyzed": {
                          "type": "text",
                          "analyzer": "nori"
                        },
                        "chosung_analyzed": {
                          "type": "text",
                          "analyzer": "hangul_chosung_analyzer"
                        }
                      }
                    },
                    "author": {
                      "type": "text"
                    },
                    "publisher": {
                      "type": "text",
                      "analyzer": "hangul_chosung_analyzer"
                    },
                    "isbn": {
                      "type": "keyword"
                    },
                    "description": {
                      "type": "text",
                      "analyzer": "nori"
                    },
                    "createdAt": {
                      "type": "date"
                    },
                    "updatedAt": {
                      "type": "date"
                    }
                  }
                }
              }'
      break
    else
      echo "[elasticsearch-mapping-init] Already Librarybooks Index Exists!"
      break
    fi
  fi
  sleep 2
done
