import {GraphQLDefinitionsFactory} from '@nestjs/graphql';
import {join} from 'path';

const definitionsFactory = new GraphQLDefinitionsFactory();
definitionsFactory.generate({
  typePaths: ['./graphql/**/*.graphql'],
  path: join(process.cwd(), 'graphql/build/graphql.schema.ts'),
  outputAs: 'interface',
  emitTypenameField: true,
  skipResolverArgs: false,
  federation: true
});
