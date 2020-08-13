SCHEMA_PATH=/main/schema/grpc

rm -R $SCHEMA_PATH/dist/* || true
mkdir $SCHEMA_PATH/dist || true

# nestjs
protoc -I $SCHEMA_PATH \
--plugin=./node_modules/.bin/protoc-gen-ts_proto \
--ts_proto_out=$SCHEMA_PATH/dist $SCHEMA_PATH/*.proto \
--ts_proto_opt=outputEncodeMethods=false,outputJsonMethods=false,outputClientImpl=false,nestJs=true,addGrpcMetadata=true