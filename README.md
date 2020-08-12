# 🌲 🐋 Yggdrasill 

Yggdrasill is a super set of tools that simplify development and deployment in a node environment, with zero configuration. All tools are dockerized.

## Phyilosophy

What's Yggdrasill? Yggdrasil (from Old Norse Yggdrasill) is an immense mythical tree that plays a central role in Norse cosmology, where it connects the Nine Worlds. (https://en.wikipedia.org/wiki/Yggdrasil).

The purpose of this repository is to unify and simplify the use of some very useful tools, such as:
* Prisma (https://www.prisma.io/)
* GRPC (https://grpc.io/)
* GraphQL (https://graphql.org/)
* Kubernetes (https://kubernetes.io/it/)
* and more ("Nine Worlds" remember?)

## 🏁 Quick start
Clone this repository into the root of the your project, as git submodule
```sh
git submodule add git@github.com:mabuonomo/yggdrasill.git
```

## 🚀 Integration
### Prisma

First of all you have to create the prisma schema (https://pris.ly/d/prisma-schema) in the following path "schema/prisma/schema.prisma" (root of the your project)

An example of the schema.prisma:
```ts
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

datasource db {
  provider = "mysql"
  url      = env("DATABASE_URL")
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

We can now to generate the typescript client 
```sh
cd yggdrasill && make prisma_generate
```

If you want to create and apply the migration at your database:
```sh
cd yggdrasill && make prisma_migrate
```

Do you use Nestjs? Read https://docs.nestjs.com/recipes/prisma

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

