# utils

# GRPC folder -> From protobuf .proto files to NestJS interfaces

example.proto
```protobuf
syntax = "proto3";
import "google/protobuf/empty.proto";

package micr_prisma;

service MicrService {
  rpc FindOne (google.protobuf.Empty) returns (UserList) {}
  rpc Save (google.protobuf.Empty) returns (User) {}
}

message User {
  string id = 1;
  string name = 2;
  string surname = 3;
}

message UserList {
  repeated User users = 1;
}
```

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