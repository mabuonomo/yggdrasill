import {GraphQLDefinitionsFactory} from '@nestjs/graphql';

const definitionsFactory = new GraphQLDefinitionsFactory();
definitionsFactory.generate({
  typePaths: ['/main/schema/graphql/**/*.graphql'],
  path: '/main/schema/graphql/dist/graphql.schema.ts',
  outputAs: 'interface',
  emitTypenameField: true,
  skipResolverArgs: false,
  federation: true
});
