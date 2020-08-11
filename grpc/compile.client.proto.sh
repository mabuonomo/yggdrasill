# nestjs
protoc \
--plugin=./node_modules/.bin/protoc-gen-ts_proto \
--ts_proto_out=./build/nestjs ./proto/*.proto \
--ts_proto_opt=outputEncodeMethods=false,outputJsonMethods=false,outputClientImpl=false,nestJs=true,addGrpcMetadata=true