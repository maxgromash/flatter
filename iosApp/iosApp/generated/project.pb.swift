// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: project.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Models_User {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var favourites: Models_Flat {
    get {return _favourites ?? Models_Flat()}
    set {_favourites = newValue}
  }
  /// Returns true if `favourites` has been explicitly set.
  var hasFavourites: Bool {return self._favourites != nil}
  /// Clears the value of `favourites`. Subsequent reads from it will return its default value.
  mutating func clearFavourites() {self._favourites = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _favourites: Models_Flat? = nil
}

struct Models_Project {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Int32 = 0

  var title: String = String()

  var description_p: String = String()

  var images: [String] = []

  var address: Models_Address {
    get {return _address ?? Models_Address()}
    set {_address = newValue}
  }
  /// Returns true if `address` has been explicitly set.
  var hasAddress: Bool {return self._address != nil}
  /// Clears the value of `address`. Subsequent reads from it will return its default value.
  mutating func clearAddress() {self._address = nil}

  var minFlatPrice: Double = 0

  var nearestTransports: [Models_NearestTransports] = []

  var streamID: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _address: Models_Address? = nil
}

struct Models_Address {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Int32 = 0

  var address: String = String()

  var coordinates: Models_Coordinates {
    get {return _coordinates ?? Models_Coordinates()}
    set {_coordinates = newValue}
  }
  /// Returns true if `coordinates` has been explicitly set.
  var hasCoordinates: Bool {return self._coordinates != nil}
  /// Clears the value of `coordinates`. Subsequent reads from it will return its default value.
  mutating func clearCoordinates() {self._coordinates = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _coordinates: Models_Coordinates? = nil
}

struct Models_Coordinates {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var latitude: Double = 0

  var longitude: Double = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_NearestTransports {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var time: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_Flat {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Int32 = 0

  var price: Double = 0

  var rooms: Int32 = 0

  var number: Int32 = 0

  var area: Int32 = 0

  var floor: Int32 = 0

  var trimming: String = String()

  var finishing: String = String()

  var images: [String] = []

  var isFavourite: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_News {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Int32 = 0

  var title: String = String()

  var description_p: String = String()

  var images: [String] = []

  var date: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_GetProjectsResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var projects: [Models_Project] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_GetFlatsRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var projectID: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_GetFlatsResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var flats: [Models_Flat] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_GetNewsResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var news: [Models_News] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_GetFavouritesRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Models_GetFavouritesResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Models_User: @unchecked Sendable {}
extension Models_Project: @unchecked Sendable {}
extension Models_Address: @unchecked Sendable {}
extension Models_Coordinates: @unchecked Sendable {}
extension Models_NearestTransports: @unchecked Sendable {}
extension Models_Flat: @unchecked Sendable {}
extension Models_News: @unchecked Sendable {}
extension Models_GetProjectsResponse: @unchecked Sendable {}
extension Models_GetFlatsRequest: @unchecked Sendable {}
extension Models_GetFlatsResponse: @unchecked Sendable {}
extension Models_GetNewsResponse: @unchecked Sendable {}
extension Models_GetFavouritesRequest: @unchecked Sendable {}
extension Models_GetFavouritesResponse: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "models"

extension Models_User: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".User"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "favourites"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._favourites) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._favourites {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_User, rhs: Models_User) -> Bool {
    if lhs._favourites != rhs._favourites {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_Project: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Project"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "title"),
    3: .same(proto: "description"),
    4: .same(proto: "images"),
    5: .same(proto: "address"),
    6: .same(proto: "minFlatPrice"),
    7: .same(proto: "nearestTransports"),
    8: .same(proto: "streamID"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.title) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.description_p) }()
      case 4: try { try decoder.decodeRepeatedStringField(value: &self.images) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._address) }()
      case 6: try { try decoder.decodeSingularDoubleField(value: &self.minFlatPrice) }()
      case 7: try { try decoder.decodeRepeatedMessageField(value: &self.nearestTransports) }()
      case 8: try { try decoder.decodeSingularInt32Field(value: &self.streamID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.id != 0 {
      try visitor.visitSingularInt32Field(value: self.id, fieldNumber: 1)
    }
    if !self.title.isEmpty {
      try visitor.visitSingularStringField(value: self.title, fieldNumber: 2)
    }
    if !self.description_p.isEmpty {
      try visitor.visitSingularStringField(value: self.description_p, fieldNumber: 3)
    }
    if !self.images.isEmpty {
      try visitor.visitRepeatedStringField(value: self.images, fieldNumber: 4)
    }
    try { if let v = self._address {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    if self.minFlatPrice != 0 {
      try visitor.visitSingularDoubleField(value: self.minFlatPrice, fieldNumber: 6)
    }
    if !self.nearestTransports.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.nearestTransports, fieldNumber: 7)
    }
    if self.streamID != 0 {
      try visitor.visitSingularInt32Field(value: self.streamID, fieldNumber: 8)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_Project, rhs: Models_Project) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.title != rhs.title {return false}
    if lhs.description_p != rhs.description_p {return false}
    if lhs.images != rhs.images {return false}
    if lhs._address != rhs._address {return false}
    if lhs.minFlatPrice != rhs.minFlatPrice {return false}
    if lhs.nearestTransports != rhs.nearestTransports {return false}
    if lhs.streamID != rhs.streamID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_Address: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Address"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "address"),
    3: .same(proto: "coordinates"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.address) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._coordinates) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.id != 0 {
      try visitor.visitSingularInt32Field(value: self.id, fieldNumber: 1)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 2)
    }
    try { if let v = self._coordinates {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_Address, rhs: Models_Address) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.address != rhs.address {return false}
    if lhs._coordinates != rhs._coordinates {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_Coordinates: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Coordinates"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    2: .same(proto: "latitude"),
    3: .same(proto: "longitude"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 2: try { try decoder.decodeSingularDoubleField(value: &self.latitude) }()
      case 3: try { try decoder.decodeSingularDoubleField(value: &self.longitude) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.latitude != 0 {
      try visitor.visitSingularDoubleField(value: self.latitude, fieldNumber: 2)
    }
    if self.longitude != 0 {
      try visitor.visitSingularDoubleField(value: self.longitude, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_Coordinates, rhs: Models_Coordinates) -> Bool {
    if lhs.latitude != rhs.latitude {return false}
    if lhs.longitude != rhs.longitude {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_NearestTransports: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NearestTransports"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "time"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.time) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if self.time != 0 {
      try visitor.visitSingularInt32Field(value: self.time, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_NearestTransports, rhs: Models_NearestTransports) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.time != rhs.time {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_Flat: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Flat"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "price"),
    3: .same(proto: "rooms"),
    4: .same(proto: "number"),
    5: .same(proto: "area"),
    6: .same(proto: "floor"),
    7: .same(proto: "trimming"),
    8: .same(proto: "finishing"),
    9: .same(proto: "images"),
    10: .same(proto: "isFavourite"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularDoubleField(value: &self.price) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.rooms) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.number) }()
      case 5: try { try decoder.decodeSingularInt32Field(value: &self.area) }()
      case 6: try { try decoder.decodeSingularInt32Field(value: &self.floor) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.trimming) }()
      case 8: try { try decoder.decodeSingularStringField(value: &self.finishing) }()
      case 9: try { try decoder.decodeRepeatedStringField(value: &self.images) }()
      case 10: try { try decoder.decodeSingularBoolField(value: &self.isFavourite) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.id != 0 {
      try visitor.visitSingularInt32Field(value: self.id, fieldNumber: 1)
    }
    if self.price != 0 {
      try visitor.visitSingularDoubleField(value: self.price, fieldNumber: 2)
    }
    if self.rooms != 0 {
      try visitor.visitSingularInt32Field(value: self.rooms, fieldNumber: 3)
    }
    if self.number != 0 {
      try visitor.visitSingularInt32Field(value: self.number, fieldNumber: 4)
    }
    if self.area != 0 {
      try visitor.visitSingularInt32Field(value: self.area, fieldNumber: 5)
    }
    if self.floor != 0 {
      try visitor.visitSingularInt32Field(value: self.floor, fieldNumber: 6)
    }
    if !self.trimming.isEmpty {
      try visitor.visitSingularStringField(value: self.trimming, fieldNumber: 7)
    }
    if !self.finishing.isEmpty {
      try visitor.visitSingularStringField(value: self.finishing, fieldNumber: 8)
    }
    if !self.images.isEmpty {
      try visitor.visitRepeatedStringField(value: self.images, fieldNumber: 9)
    }
    if self.isFavourite != false {
      try visitor.visitSingularBoolField(value: self.isFavourite, fieldNumber: 10)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_Flat, rhs: Models_Flat) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.price != rhs.price {return false}
    if lhs.rooms != rhs.rooms {return false}
    if lhs.number != rhs.number {return false}
    if lhs.area != rhs.area {return false}
    if lhs.floor != rhs.floor {return false}
    if lhs.trimming != rhs.trimming {return false}
    if lhs.finishing != rhs.finishing {return false}
    if lhs.images != rhs.images {return false}
    if lhs.isFavourite != rhs.isFavourite {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_News: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".News"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "title"),
    3: .same(proto: "description"),
    4: .same(proto: "images"),
    5: .same(proto: "date"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.title) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.description_p) }()
      case 4: try { try decoder.decodeRepeatedStringField(value: &self.images) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.date) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.id != 0 {
      try visitor.visitSingularInt32Field(value: self.id, fieldNumber: 1)
    }
    if !self.title.isEmpty {
      try visitor.visitSingularStringField(value: self.title, fieldNumber: 2)
    }
    if !self.description_p.isEmpty {
      try visitor.visitSingularStringField(value: self.description_p, fieldNumber: 3)
    }
    if !self.images.isEmpty {
      try visitor.visitRepeatedStringField(value: self.images, fieldNumber: 4)
    }
    if !self.date.isEmpty {
      try visitor.visitSingularStringField(value: self.date, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_News, rhs: Models_News) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.title != rhs.title {return false}
    if lhs.description_p != rhs.description_p {return false}
    if lhs.images != rhs.images {return false}
    if lhs.date != rhs.date {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_GetProjectsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetProjectsResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "projects"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.projects) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.projects.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.projects, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_GetProjectsResponse, rhs: Models_GetProjectsResponse) -> Bool {
    if lhs.projects != rhs.projects {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_GetFlatsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetFlatsRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "projectID"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.projectID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.projectID != 0 {
      try visitor.visitSingularInt32Field(value: self.projectID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_GetFlatsRequest, rhs: Models_GetFlatsRequest) -> Bool {
    if lhs.projectID != rhs.projectID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_GetFlatsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetFlatsResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "flats"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.flats) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.flats.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.flats, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_GetFlatsResponse, rhs: Models_GetFlatsResponse) -> Bool {
    if lhs.flats != rhs.flats {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_GetNewsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetNewsResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "news"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.news) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.news.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.news, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_GetNewsResponse, rhs: Models_GetNewsResponse) -> Bool {
    if lhs.news != rhs.news {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_GetFavouritesRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetFavouritesRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_GetFavouritesRequest, rhs: Models_GetFavouritesRequest) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Models_GetFavouritesResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetFavouritesResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Models_GetFavouritesResponse, rhs: Models_GetFavouritesResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
