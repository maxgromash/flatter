PROTO_SOURCES := ../shared/src/proto

proto:
	for proto_file in $(PROTO_SOURCES)/*.proto; do \
		protoc \
		--plugin=Pods/gRPC-Swift-Plugins/bin/protoc-gen-swift \
		--swift_out=iosApp/generated \
		--proto_path=$(PROTO_SOURCES) \
		$$proto_file; \
		protoc \
		--plugin=Pods/gRPC-Swift-Plugins/bin/protoc-gen-grpc-swift \
		--grpc-swift_out=iosApp/generated \
		--grpc-swift_opt=Client=true,Server=false \
		--proto_path=$(PROTO_SOURCES) \
		$$proto_file; \
	done

		