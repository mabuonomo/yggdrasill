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

schema.prisma
```ts
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

datasource db {
  provider = "mysql"
  url      = "mysql://root:root@mysql:3306/vivus?schema=public"
  //env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
  output   = "/main/node_modules/@prisma/client"
}

model User {
  id            Int      @default(autoincrement()) @id
  createdAt     DateTime @default(now())
  email         String   @unique
  givenName     String
  familyName    String
  // role       Role     @default(USER)
  posts         Post[]
  profile       Profile?
  nickname      String   @unique
  picture       String
  emailVerified Boolean
}

model Profile {
  id     Int    @default(autoincrement()) @id
  bio    String
  user   User   @relation(fields: [userId], references: [id])
  userId Int
}

model Post {
  id         Int        @default(autoincrement()) @id
  createdAt  DateTime   @default(now())
  title      String
  published  Boolean    @default(false)
  categories Category[] @relation(references: [id])
  author     User       @relation(fields: [authorId], references: [id])
  authorId   Int
}

model Category {
  id    Int    @default(autoincrement()) @id
  name  String
  posts Post[] @relation(references: [id])
}

enum Role {
  USER
  ADMIN
}

```