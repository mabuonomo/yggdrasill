# 🌲 🐋 Yggdrasill

**Yggdrasill** is a super set of tools that simplify development and deployment in a node environment, NestJS (https://docs.nestjs.com/) in particular, with zero configuration. All tools are dockerized.

## Phyilosophy

What's Yggdrasill? Yggdrasil (from Old Norse Yggdrasill) is an immense mythical tree that plays a central role in Norse cosmology, where it connects the Nine Worlds. (https://en.wikipedia.org/wiki/Yggdrasil).

The purpose of this repository is to unify and simplify the use of some very useful tools, such as:

- Prisma (https://www.prisma.io/)
- GRPC (https://grpc.io/)
- GraphQL (https://graphql.org/)
- Kubernetes (https://kubernetes.io/it/) --> WIP
- and more ("Nine Worlds" remember?) --> WIP

## ☠️ Prerequisites

- Make
- Docker
- Docker-compose
- NestJS (if you use GRPC part)

## 🏁 Quick start

Clone this repository into the root of the your project, as git submodule

```sh
git submodule add git@github.com:mabuonomo/yggdrasill.git
```

## 🚀 Integration

Some examples of integration

---

## Prisma

_Create client and migration from a schema.prisma file_

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
cd yggdrasill && make prisma_build
```

If you want to create and apply the migration at your database:

```sh
cd yggdrasill && make prisma_migrate
```

Do you use Nestjs? Read https://docs.nestjs.com/recipes/prisma

---

## GraphQL

_Create NestJS's interfaces from \*.graphql files_

First of all you have to create the graphql schema in the following path "schema/graphql/example.graphql" (root of the your project)

An example of the example.graphql:

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

We can now to generate the typescript interfaces

```sh
cd yggdrasill && make graphql_build
```

The command will generate the following code (schema/graphql/dist):

```ts
/** ------------------------------------------------------
 * THIS FILE WAS AUTOMATICALLY GENERATED (DO NOT MODIFY)
 * -------------------------------------------------------
 */

/* tslint:disable */
/* eslint-disable */
export interface CreateCatInput {
  name?: string;
  age?: number;
}

export interface Cat {
  __typename?: "Cat";
  id?: number;
  name?: string;
  age?: number;
}

export interface IMutation {
  __typename?: "IMutation";
  createCat(createCatInput?: CreateCatInput): Cat | Promise<Cat>;
}

export interface IQuery {
  __typename?: "IQuery";
  getCats(): Cat[] | Promise<Cat[]>;
  cat(id: string): Cat | Promise<Cat>;
}

export interface ISubscription {
  __typename?: "ISubscription";
  catCreated(): Cat | Promise<Cat>;
}
```

Do you use Nestjs? Read https://docs.nestjs.com/graphql/quick-start

---

## Grpc

_Create NestJS's interfaces from \*.proto files_

First of all you have to create the protobuf schema in the following path "schema/grpc/example.proto" (root of the your project)

An example of the example.proto:

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

We can now to generate the typescript interfaces

```sh
cd yggdrasill && make grpc_build
```

The command will generate the following code (schema/grpc/dist):

```ts
/* eslint-disable */
import { Empty } from "./google/protobuf/empty";
import { Metadata } from "grpc";
import { Observable } from "rxjs";
import { GrpcMethod, GrpcStreamMethod } from "@nestjs/microservices";

export interface User {
  id: string;
  name: string;
  surname: string;
}

export interface UserList {
  users: User[];
}

export interface MicrServiceController {
  findOne(
    request: Empty,
    metadata?: Metadata
  ): Promise<UserList> | Observable<UserList> | UserList;

  save(
    request: Empty,
    metadata?: Metadata
  ): Promise<User> | Observable<User> | User;
}

export interface MicrServiceClient {
  findOne(request: Empty, metadata?: Metadata): Observable<UserList>;

  save(request: Empty, metadata?: Metadata): Observable<User>;
}

export function MicrServiceControllerMethods() {
  return function (constructor: Function) {
    const grpcMethods: string[] = ["findOne", "save"];
    for (const method of grpcMethods) {
      const descriptor: any = Reflect.getOwnPropertyDescriptor(
        constructor.prototype,
        method
      );
      GrpcMethod("MicrService", method)(
        constructor.prototype[method],
        method,
        descriptor
      );
    }
    const grpcStreamMethods: string[] = [];
    for (const method of grpcStreamMethods) {
      const descriptor: any = Reflect.getOwnPropertyDescriptor(
        constructor.prototype,
        method
      );
      GrpcStreamMethod("MicrService", method)(
        constructor.prototype[method],
        method,
        descriptor
      );
    }
  };
}

export const MICR_PRISMA_PACKAGE_NAME = "micr_prisma";
export const MICR_SERVICE_NAME = "MicrService";
```

Do you use Nestjs? Read https://docs.nestjs.com/microservices/grpc
