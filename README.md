# utils

# GRPC folder -> From protobuf .proto files to NestJS interfaces

# GRAPHQL folder -> from graphql .graphql files to NestJs interfaces

example.graphql
```ts
type Query {
  getCats: [Cat]
  cat(id: ID!): Cat
}

type Mutation {
  createCat(createCatInput: CreateCatInput): Cat
}

type Subscription {
  catCreated: Cat
}

type Cat {
  id: Int
  name: String
  age: Int
}

input CreateCatInput {
  name: String
  age: Int
}
```