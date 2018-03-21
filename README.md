# API Workshop

A HTTP web based API interactive workshop using simple cURL commands to:
  - GET an endpoint
  - POST some data
  - work with various approaches and formats:
    - REST
    - JSON API
    - HATEOAS
    - GraphQL
  - look into implementations of various techniques
    - authentication/authorization
    - CORS
    - CSRF form protection
  - etc

## Progress

To run

    ```
    $ ruby lib/app.rb

    $ curl http://localhost:4567
    Hi and welcome to the API tutorial
    ...

    $ curl -H Accept:application/json http://localhost:4567 | jq
    {
      "message": "Successfully completed challenge 0, hit API with content-type 'application/json'",
      "links": {
        "self": "http://localhost:4567",
        "next": "http://localhost:4567/challenge/1"
      }
    }

    $ curl -H Accept:application/json http://localhost:4567/challenge/1 | jq
    {
      "data": {
        "type": "challenge",
        "id": "1",
        "attributes": {
          "text": "provide an endpoint that responds with a 200 OK",
          "hint": "pass your endpoint `curl --data {'endpoint'='http://localhost:3000'} ..."
        }
      },
      "links": {
        "prev": "http://localhost:4567",
        "self": "http://localhost:4567/challenge/1",
        "next": "http://localhost:4567/challenge/2"
      }
    }

    $ curl --data {'endpoint'='http://localhost:3000'} \
        -H Accept:application/json http://localhost:4567/challenge/1 | jq
    {
      "data": {
        "type": "challenge",
        "id": "1",
        "attributes": {
          "text": "provide an endpoint that responds with a 200 OK",
          "hint": "pass your endpoint `curl --data {'endpoint'='http://localhost:3000'} ...",
          "status": "in progress"
        }
      },
      "links": {
        "prev": "http://localhost:4567",
        "self": "http://localhost:4567/challenge/1",
        "next": "http://localhost:4567/challenge/2"
      }
    }
    ```

## TODO

- [ ] write cucumber or similar integration test that calls out solutions as
  per to run section above
- [ ] print out a message when sinatra starts as to what to do next, curl the
  endpoint
- [ ] auto reload sinatra with changes
- [ ] 404 application/json handler needs to be added - currently 404 in HTML
- [ ] links are example.org and not the actual host and port?
- [ ] split progress into section with more purpose
- [ ] animated gif of how you progress through some of this

