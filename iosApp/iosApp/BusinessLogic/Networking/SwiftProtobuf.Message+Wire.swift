import Foundation
import SwiftProtobuf
import shared

extension SwiftProtobuf.Message {
    func toWireMessage<WireMessage, Adapter: Wire_runtimeProtoAdapter<WireMessage>>(adapter: Adapter) -> (WireMessage?, KotlinException?) {
        do {
            let data = try self.serializedData()
            let result = adapter.decode(bytes: data.toKotlinByteArray())

            if let nResult = result {
                return (nResult, nil)
            } else {
                return (nil, KotlinException(message: "Cannot parse message data"))
            }
        } catch let err {
            return (nil, KotlinException(message: err.localizedDescription))
        }
    }
}

extension Data {
    //Побайтово копируем NSData в KotlinByteArray
    func toKotlinByteArray() -> KotlinByteArray {
        let nsData = NSData(data: self)

        return KotlinByteArray(size: Int32(self.count)) { index -> KotlinByte in
            let byte = nsData.bytes.load(fromByteOffset: Int(truncating: index), as: Int8.self)
            return KotlinByte(value: byte)
        }
    }
}
