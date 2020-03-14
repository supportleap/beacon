# Beacon

A simple rails app for the Leap status page.

![beacon-screenshot](https://user-images.githubusercontent.com/858504/43363266-04367fa4-92b6-11e8-8632-136e981e96d0.png)

## API

Set the `API_KEY` environment variable to a randomly generated string. You can then access a basic GraphQL API at `/api/graphql`.

## Chatops

This uses [chatops-controller](https://github.com/github/chatops-controller) to implement [Chatops RPC](https://github.com/github/chatops-controller/blob/master/docs/protocol-description.md).

There's a couple chatops commands supported:


`.beacon sup` – See the current status.
`.beacon set <level> <message>` - Set the current status. Message is optional.

## Developing

```
script/setup
script/server
open http://beacon.localhost
```

The development environment is seeded with some status events for your convenience.
