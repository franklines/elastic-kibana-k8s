#!/bin/bash
# Author: Franklin E.
# Desc: The following Bash Script utilizes the OpenLibrary.org API to generate data for our ElasticSearch instance.
# API Info: https://openlibrary.org/developers/api

BOOK_API_ENDPOINT="https://openlibrary.org";
ELASTICSEARCH_HOST="http://localhost:9200";


function indexInit()
{
    curl -s -X PUT "${ELASTICSEARCH_HOST}/linux_books";
}


function generateData()
{
    for i in {0..99};
    do
        ISBN=$(curl -s "${BOOK_API_ENDPOINT}/search.json?q=linux"| python -c "import sys, json; print(json.load(sys.stdin)['docs'][${i}]['isbn'][0])");
        echo "ISBN: ${ISBN}";
        BOOK=$(curl -s "${BOOK_API_ENDPOINT}/api/books?bibkeys=ISBN:${ISBN}&format=json");
        echo "BOOK: ${BOOK}";
        curl -s -X POST -H 'Content-Type: application/json' -d "${BOOK}" "${ELASTICSEARCH_HOST}/linux_books/json/${ISBN}";
    done
}

indexInit;
generateData;