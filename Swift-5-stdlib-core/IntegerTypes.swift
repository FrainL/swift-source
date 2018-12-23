// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1)
//===--- Integers.swift.gyb -----------------------------------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 64)

// FIXME(integers): remove these two aliases
/// The largest native signed integer type.
@available(swift, obsoleted: 4.0, renamed: "Int64")
public typealias IntMax = Int64
/// The largest native unsigned integer type.
@available(swift, obsoleted: 4.0, renamed: "UInt64")
public typealias UIntMax = UInt64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1075)

//===----------------------------------------------------------------------===//
//===--- Concrete FixedWidthIntegers --------------------------------------===//
//===----------------------------------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// An 8-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct UInt8
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt8


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int8(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: Int8) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt8 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt8 because the result would be less than UInt8.min")
    _precondition(source < 256.0,
      "Float value cannot be converted to UInt8 because the result would be greater than UInt8.max")
    self._value = Builtin.fptoui_FPIEEE32_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 256.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE32_Int8(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt8 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt8 because the result would be less than UInt8.min")
    _precondition(source < 256.0,
      "Double value cannot be converted to UInt8 because the result would be greater than UInt8.max")
    self._value = Builtin.fptoui_FPIEEE64_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 256.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE64_Int8(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt8 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt8 because the result would be less than UInt8.min")
    _precondition(source < 256.0,
      "Float80 value cannot be converted to UInt8 because the result would be greater than UInt8.max")
    self._value = Builtin.fptoui_FPIEEE80_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 256.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE80_Int8(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: UInt8, rhs: UInt8) -> Bool {
    return Bool(Builtin.cmp_eq_Int8(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: UInt8, rhs: UInt8) -> Bool {
    return Bool(Builtin.cmp_ult_Int8(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout UInt8, rhs: UInt8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout UInt8, rhs: UInt8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout UInt8, rhs: UInt8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout UInt8, rhs: UInt8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt8)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.udiv_Int8(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.udiv_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.urem_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout UInt8, rhs: UInt8) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt8)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.urem_Int8(lhs._value, rhs._value),
      false._value)
    lhs = UInt8(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int8) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout UInt8, rhs: UInt8) {
    lhs = UInt8(Builtin.and_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout UInt8, rhs: UInt8) {
    lhs = UInt8(Builtin.or_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout UInt8, rhs: UInt8) {
    lhs = UInt8(Builtin.xor_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout UInt8, rhs: UInt8) {
    let rhs_ = rhs & 7
    lhs = UInt8(
      Builtin.lshr_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout UInt8, rhs: UInt8) {
    let rhs_ = rhs & 7
    lhs = UInt8(
      Builtin.shl_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of an `UInt8` instance is 8.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 8 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt8(
        Builtin.int_ctlz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt8(
        Builtin.int_cttz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt8(
        Builtin.int_ctpop_Int8(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt8.Words>

    @usableFromInline
    internal var _value: UInt8

    @inlinable
    public init(_ value: UInt8) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (8 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt8(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.zextOrBitCast_Int8_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int8(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt8

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: UInt8)
    -> (high: UInt8, low: UInt8.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.zext_Int8_Int16(self._value)
    let rhs_ = Builtin.zext_Int8_Int16(other._value)

    let res = Builtin.mul_Int16(lhs_, rhs_)
    let low = UInt8.Magnitude(Builtin.truncOrBitCast_Int16_Int8(res))
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let shifted = Builtin.ashr_Int16(res, shift)
    let high = UInt8(Builtin.truncOrBitCast_Int16_Int8(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: UInt8, low: UInt8.Magnitude)
  ) -> (quotient: UInt8, remainder: UInt8) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int8_Int16(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let lhsHighShifted = Builtin.shl_Int16(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int8_Int16(dividend.low._value)
    let lhs_ = Builtin.or_Int16(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int8_Int16(self._value)

    let quotient_ = Builtin.udiv_Int16(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int16(lhs_, rhs_)

    let quotient = UInt8(
      Builtin.truncOrBitCast_Int16_Int8(quotient_))
    let remainder = UInt8(
      Builtin.truncOrBitCast_Int16_Int8(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: UInt8 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1599)
    return self
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int8

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt8 { return 8 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt8 { return 8/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> UInt8 {
    let isPositive = UInt8(Builtin.zext_Int1_Int8(
      (self > (0 as UInt8))._value))
    return isPositive | (self &>> 7)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension UInt8 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt8(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1675)
    return Hasher._hash(
      seed: seed,
      bytes: UInt64(truncatingIfNeeded: UInt8(_value)),
      count: 1)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension UInt8 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt16) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int16) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt8 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: UInt8, rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt8, rhs: UInt8
  ) -> UInt8 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt8, rhs: UInt8
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt8, rhs: UInt8
  ) -> UInt8 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt8, rhs: UInt8
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: UInt8, rhs: UInt8) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: UInt8, rhs: UInt8) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: UInt8, rhs: UInt8) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// An 8-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct Int8
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int8


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int8(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: UInt8) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int8 because it is either infinite or NaN")
    _precondition(source > -129.0,
      "Float value cannot be converted to Int8 because the result would be less than Int8.min")
    _precondition(source < 128.0,
      "Float value cannot be converted to Int8 because the result would be greater than Int8.max")
    self._value = Builtin.fptosi_FPIEEE32_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -129.0 && source < 128.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE32_Int8(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int8 because it is either infinite or NaN")
    _precondition(source > -129.0,
      "Double value cannot be converted to Int8 because the result would be less than Int8.min")
    _precondition(source < 128.0,
      "Double value cannot be converted to Int8 because the result would be greater than Int8.max")
    self._value = Builtin.fptosi_FPIEEE64_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -129.0 && source < 128.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE64_Int8(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int8 because it is either infinite or NaN")
    _precondition(source > -129.0,
      "Float80 value cannot be converted to Int8 because the result would be less than Int8.min")
    _precondition(source < 128.0,
      "Float80 value cannot be converted to Int8 because the result would be greater than Int8.max")
    self._value = Builtin.fptosi_FPIEEE80_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -129.0 && source < 128.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE80_Int8(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: Int8, rhs: Int8) -> Bool {
    return Bool(Builtin.cmp_eq_Int8(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: Int8, rhs: Int8) -> Bool {
    return Bool(Builtin.cmp_slt_Int8(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout Int8, rhs: Int8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout Int8, rhs: Int8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout Int8, rhs: Int8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout Int8, rhs: Int8) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int8)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1235)
    if _slowPath(
      lhs == Int8.min && rhs == (-1 as Int8)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.sdiv_Int8(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int8.min && other == (-1 as Int8)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int8.min && other == (-1 as Int8)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.srem_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout Int8, rhs: Int8) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int8)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1302)
    if _slowPath(lhs == Int8.min && rhs == (-1 as Int8)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.srem_Int8(lhs._value, rhs._value),
      false._value)
    lhs = Int8(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int8) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout Int8, rhs: Int8) {
    lhs = Int8(Builtin.and_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout Int8, rhs: Int8) {
    lhs = Int8(Builtin.or_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout Int8, rhs: Int8) {
    lhs = Int8(Builtin.xor_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout Int8, rhs: Int8) {
    let rhs_ = rhs & 7
    lhs = Int8(
      Builtin.ashr_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout Int8, rhs: Int8) {
    let rhs_ = rhs & 7
    lhs = Int8(
      Builtin.shl_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of an `Int8` instance is 8.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 8 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int8(
        Builtin.int_ctlz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int8(
        Builtin.int_cttz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int8(
        Builtin.int_ctpop_Int8(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int8.Words>

    @usableFromInline
    internal var _value: Int8

    @inlinable
    public init(_ value: Int8) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (8 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int8(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1447)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.sextOrBitCast_Int8_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int8(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt8

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1478)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @_transparent
  public var magnitude: UInt8 {
    let base = UInt8(_value)
    return self < (0 as Int8) ? ~base &+ 1 : base
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: Int8)
    -> (high: Int8, low: Int8.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.sext_Int8_Int16(self._value)
    let rhs_ = Builtin.sext_Int8_Int16(other._value)

    let res = Builtin.mul_Int16(lhs_, rhs_)
    let low = Int8.Magnitude(Builtin.truncOrBitCast_Int16_Int8(res))
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let shifted = Builtin.ashr_Int16(res, shift)
    let high = Int8(Builtin.truncOrBitCast_Int16_Int8(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: Int8, low: Int8.Magnitude)
  ) -> (quotient: Int8, remainder: Int8) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int8_Int16(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let lhsHighShifted = Builtin.shl_Int16(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int8_Int16(dividend.low._value)
    let lhs_ = Builtin.or_Int16(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int8_Int16(self._value)

    let quotient_ = Builtin.sdiv_Int16(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int16(lhs_, rhs_)

    let quotient = Int8(
      Builtin.truncOrBitCast_Int16_Int8(quotient_))
    let remainder = Int8(
      Builtin.truncOrBitCast_Int16_Int8(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: Int8 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1599)
    return self
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int8

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int8 { return 8 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int8 { return 8/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> Int8 {
    let isPositive = Int8(Builtin.zext_Int1_Int8(
      (self > (0 as Int8))._value))
    return isPositive | (self &>> 7)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension Int8 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt8(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1675)
    return Hasher._hash(
      seed: seed,
      bytes: UInt64(truncatingIfNeeded: UInt8(_value)),
      count: 1)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension Int8 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt16) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int16) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int8 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: Int8, rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int8, rhs: Int8
  ) -> Int8 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int8, rhs: Int8
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int8, rhs: Int8
  ) -> Int8 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int8, rhs: Int8
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: Int8, rhs: Int8) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: Int8, rhs: Int8) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: Int8, rhs: Int8) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1782)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@_transparent
public func _assumeNonNegative(_ x: Int8) -> Int8 {
  _internalInvariant(x >= (0 as Int8))
  return Int8(Builtin.assumeNonNegative_Int8(x._value))
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// A 16-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct UInt16
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt16


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int16(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: Int16) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt16 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt16 because the result would be less than UInt16.min")
    _precondition(source < 65536.0,
      "Float value cannot be converted to UInt16 because the result would be greater than UInt16.max")
    self._value = Builtin.fptoui_FPIEEE32_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 65536.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE32_Int16(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt16 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt16 because the result would be less than UInt16.min")
    _precondition(source < 65536.0,
      "Double value cannot be converted to UInt16 because the result would be greater than UInt16.max")
    self._value = Builtin.fptoui_FPIEEE64_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 65536.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE64_Int16(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt16 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt16 because the result would be less than UInt16.min")
    _precondition(source < 65536.0,
      "Float80 value cannot be converted to UInt16 because the result would be greater than UInt16.max")
    self._value = Builtin.fptoui_FPIEEE80_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 65536.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE80_Int16(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: UInt16, rhs: UInt16) -> Bool {
    return Bool(Builtin.cmp_eq_Int16(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: UInt16, rhs: UInt16) -> Bool {
    return Bool(Builtin.cmp_ult_Int16(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout UInt16, rhs: UInt16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout UInt16, rhs: UInt16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout UInt16, rhs: UInt16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout UInt16, rhs: UInt16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt16)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.udiv_Int16(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.udiv_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.urem_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout UInt16, rhs: UInt16) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt16)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.urem_Int16(lhs._value, rhs._value),
      false._value)
    lhs = UInt16(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int16) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout UInt16, rhs: UInt16) {
    lhs = UInt16(Builtin.and_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout UInt16, rhs: UInt16) {
    lhs = UInt16(Builtin.or_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout UInt16, rhs: UInt16) {
    lhs = UInt16(Builtin.xor_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout UInt16, rhs: UInt16) {
    let rhs_ = rhs & 15
    lhs = UInt16(
      Builtin.lshr_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout UInt16, rhs: UInt16) {
    let rhs_ = rhs & 15
    lhs = UInt16(
      Builtin.shl_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of a `UInt16` instance is 16.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 16 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt16(
        Builtin.int_ctlz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt16(
        Builtin.int_cttz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt16(
        Builtin.int_ctpop_Int16(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt16.Words>

    @usableFromInline
    internal var _value: UInt16

    @inlinable
    public init(_ value: UInt16) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (16 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt16(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.zextOrBitCast_Int16_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int16(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt16

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: UInt16)
    -> (high: UInt16, low: UInt16.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.zext_Int16_Int32(self._value)
    let rhs_ = Builtin.zext_Int16_Int32(other._value)

    let res = Builtin.mul_Int32(lhs_, rhs_)
    let low = UInt16.Magnitude(Builtin.truncOrBitCast_Int32_Int16(res))
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let shifted = Builtin.ashr_Int32(res, shift)
    let high = UInt16(Builtin.truncOrBitCast_Int32_Int16(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: UInt16, low: UInt16.Magnitude)
  ) -> (quotient: UInt16, remainder: UInt16) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int16_Int32(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let lhsHighShifted = Builtin.shl_Int32(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int16_Int32(dividend.low._value)
    let lhs_ = Builtin.or_Int32(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int16_Int32(self._value)

    let quotient_ = Builtin.udiv_Int32(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int32(lhs_, rhs_)

    let quotient = UInt16(
      Builtin.truncOrBitCast_Int32_Int16(quotient_))
    let remainder = UInt16(
      Builtin.truncOrBitCast_Int32_Int16(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: UInt16 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return UInt16(Builtin.int_bswap_Int16(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int16

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt16 { return 16 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt16 { return 16/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> UInt16 {
    let isPositive = UInt16(Builtin.zext_Int1_Int16(
      (self > (0 as UInt16))._value))
    return isPositive | (self &>> 15)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension UInt16 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt16(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1675)
    return Hasher._hash(
      seed: seed,
      bytes: UInt64(truncatingIfNeeded: UInt16(_value)),
      count: 2)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension UInt16 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt16 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: UInt16, rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt16, rhs: UInt16
  ) -> UInt16 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt16, rhs: UInt16
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt16, rhs: UInt16
  ) -> UInt16 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt16, rhs: UInt16
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: UInt16, rhs: UInt16) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: UInt16, rhs: UInt16) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: UInt16, rhs: UInt16) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// A 16-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct Int16
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int16


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int16(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: UInt16) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int16 because it is either infinite or NaN")
    _precondition(source > -32769.0,
      "Float value cannot be converted to Int16 because the result would be less than Int16.min")
    _precondition(source < 32768.0,
      "Float value cannot be converted to Int16 because the result would be greater than Int16.max")
    self._value = Builtin.fptosi_FPIEEE32_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -32769.0 && source < 32768.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE32_Int16(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int16 because it is either infinite or NaN")
    _precondition(source > -32769.0,
      "Double value cannot be converted to Int16 because the result would be less than Int16.min")
    _precondition(source < 32768.0,
      "Double value cannot be converted to Int16 because the result would be greater than Int16.max")
    self._value = Builtin.fptosi_FPIEEE64_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -32769.0 && source < 32768.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE64_Int16(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int16 because it is either infinite or NaN")
    _precondition(source > -32769.0,
      "Float80 value cannot be converted to Int16 because the result would be less than Int16.min")
    _precondition(source < 32768.0,
      "Float80 value cannot be converted to Int16 because the result would be greater than Int16.max")
    self._value = Builtin.fptosi_FPIEEE80_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -32769.0 && source < 32768.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE80_Int16(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: Int16, rhs: Int16) -> Bool {
    return Bool(Builtin.cmp_eq_Int16(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: Int16, rhs: Int16) -> Bool {
    return Bool(Builtin.cmp_slt_Int16(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout Int16, rhs: Int16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout Int16, rhs: Int16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout Int16, rhs: Int16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout Int16, rhs: Int16) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int16)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1235)
    if _slowPath(
      lhs == Int16.min && rhs == (-1 as Int16)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.sdiv_Int16(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int16.min && other == (-1 as Int16)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int16.min && other == (-1 as Int16)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.srem_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout Int16, rhs: Int16) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int16)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1302)
    if _slowPath(lhs == Int16.min && rhs == (-1 as Int16)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.srem_Int16(lhs._value, rhs._value),
      false._value)
    lhs = Int16(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int16) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout Int16, rhs: Int16) {
    lhs = Int16(Builtin.and_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout Int16, rhs: Int16) {
    lhs = Int16(Builtin.or_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout Int16, rhs: Int16) {
    lhs = Int16(Builtin.xor_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout Int16, rhs: Int16) {
    let rhs_ = rhs & 15
    lhs = Int16(
      Builtin.ashr_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout Int16, rhs: Int16) {
    let rhs_ = rhs & 15
    lhs = Int16(
      Builtin.shl_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of a `Int16` instance is 16.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 16 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int16(
        Builtin.int_ctlz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int16(
        Builtin.int_cttz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int16(
        Builtin.int_ctpop_Int16(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int16.Words>

    @usableFromInline
    internal var _value: Int16

    @inlinable
    public init(_ value: Int16) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (16 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int16(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1447)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.sextOrBitCast_Int16_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int16(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt16

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1478)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @_transparent
  public var magnitude: UInt16 {
    let base = UInt16(_value)
    return self < (0 as Int16) ? ~base &+ 1 : base
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: Int16)
    -> (high: Int16, low: Int16.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.sext_Int16_Int32(self._value)
    let rhs_ = Builtin.sext_Int16_Int32(other._value)

    let res = Builtin.mul_Int32(lhs_, rhs_)
    let low = Int16.Magnitude(Builtin.truncOrBitCast_Int32_Int16(res))
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let shifted = Builtin.ashr_Int32(res, shift)
    let high = Int16(Builtin.truncOrBitCast_Int32_Int16(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: Int16, low: Int16.Magnitude)
  ) -> (quotient: Int16, remainder: Int16) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int16_Int32(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let lhsHighShifted = Builtin.shl_Int32(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int16_Int32(dividend.low._value)
    let lhs_ = Builtin.or_Int32(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int16_Int32(self._value)

    let quotient_ = Builtin.sdiv_Int32(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int32(lhs_, rhs_)

    let quotient = Int16(
      Builtin.truncOrBitCast_Int32_Int16(quotient_))
    let remainder = Int16(
      Builtin.truncOrBitCast_Int32_Int16(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: Int16 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return Int16(Builtin.int_bswap_Int16(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int16

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int16 { return 16 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int16 { return 16/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> Int16 {
    let isPositive = Int16(Builtin.zext_Int1_Int16(
      (self > (0 as Int16))._value))
    return isPositive | (self &>> 15)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension Int16 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt16(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1675)
    return Hasher._hash(
      seed: seed,
      bytes: UInt64(truncatingIfNeeded: UInt16(_value)),
      count: 2)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension Int16 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int16 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: Int16, rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int16, rhs: Int16
  ) -> Int16 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int16, rhs: Int16
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int16, rhs: Int16
  ) -> Int16 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int16, rhs: Int16
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: Int16, rhs: Int16) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: Int16, rhs: Int16) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: Int16, rhs: Int16) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1782)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@_transparent
public func _assumeNonNegative(_ x: Int16) -> Int16 {
  _internalInvariant(x >= (0 as Int16))
  return Int16(Builtin.assumeNonNegative_Int16(x._value))
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// A 32-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct UInt32
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt32


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int32(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: Int32) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt32 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt32 because the result would be less than UInt32.min")
    _precondition(source < 4294967296.0,
      "Float value cannot be converted to UInt32 because the result would be greater than UInt32.max")
    self._value = Builtin.fptoui_FPIEEE32_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 4294967296.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE32_Int32(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt32 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt32 because the result would be less than UInt32.min")
    _precondition(source < 4294967296.0,
      "Double value cannot be converted to UInt32 because the result would be greater than UInt32.max")
    self._value = Builtin.fptoui_FPIEEE64_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 4294967296.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE64_Int32(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt32 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt32 because the result would be less than UInt32.min")
    _precondition(source < 4294967296.0,
      "Float80 value cannot be converted to UInt32 because the result would be greater than UInt32.max")
    self._value = Builtin.fptoui_FPIEEE80_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 4294967296.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE80_Int32(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: UInt32, rhs: UInt32) -> Bool {
    return Bool(Builtin.cmp_eq_Int32(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: UInt32, rhs: UInt32) -> Bool {
    return Bool(Builtin.cmp_ult_Int32(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout UInt32, rhs: UInt32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout UInt32, rhs: UInt32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout UInt32, rhs: UInt32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout UInt32, rhs: UInt32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt32)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.udiv_Int32(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.udiv_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.urem_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout UInt32, rhs: UInt32) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt32)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.urem_Int32(lhs._value, rhs._value),
      false._value)
    lhs = UInt32(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int32) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout UInt32, rhs: UInt32) {
    lhs = UInt32(Builtin.and_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout UInt32, rhs: UInt32) {
    lhs = UInt32(Builtin.or_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout UInt32, rhs: UInt32) {
    lhs = UInt32(Builtin.xor_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout UInt32, rhs: UInt32) {
    let rhs_ = rhs & 31
    lhs = UInt32(
      Builtin.lshr_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout UInt32, rhs: UInt32) {
    let rhs_ = rhs & 31
    lhs = UInt32(
      Builtin.shl_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of a `UInt32` instance is 32.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 32 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt32(
        Builtin.int_ctlz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt32(
        Builtin.int_cttz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt32(
        Builtin.int_ctpop_Int32(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt32.Words>

    @usableFromInline
    internal var _value: UInt32

    @inlinable
    public init(_ value: UInt32) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (32 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt32(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.zextOrBitCast_Int32_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int32(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt32

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: UInt32)
    -> (high: UInt32, low: UInt32.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.zext_Int32_Int64(self._value)
    let rhs_ = Builtin.zext_Int32_Int64(other._value)

    let res = Builtin.mul_Int64(lhs_, rhs_)
    let low = UInt32.Magnitude(Builtin.truncOrBitCast_Int64_Int32(res))
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let shifted = Builtin.ashr_Int64(res, shift)
    let high = UInt32(Builtin.truncOrBitCast_Int64_Int32(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: UInt32, low: UInt32.Magnitude)
  ) -> (quotient: UInt32, remainder: UInt32) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int32_Int64(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let lhsHighShifted = Builtin.shl_Int64(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int32_Int64(dividend.low._value)
    let lhs_ = Builtin.or_Int64(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int32_Int64(self._value)

    let quotient_ = Builtin.udiv_Int64(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int64(lhs_, rhs_)

    let quotient = UInt32(
      Builtin.truncOrBitCast_Int64_Int32(quotient_))
    let remainder = UInt32(
      Builtin.truncOrBitCast_Int64_Int32(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: UInt32 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return UInt32(Builtin.int_bswap_Int32(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int32

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt32 { return 32 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt32 { return 32/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> UInt32 {
    let isPositive = UInt32(Builtin.zext_Int1_Int32(
      (self > (0 as UInt32))._value))
    return isPositive | (self &>> 31)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension UInt32 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt32(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1675)
    return Hasher._hash(
      seed: seed,
      bytes: UInt64(truncatingIfNeeded: UInt32(_value)),
      count: 4)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension UInt32 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt32 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: UInt32, rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt32, rhs: UInt32
  ) -> UInt32 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt32, rhs: UInt32
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt32, rhs: UInt32
  ) -> UInt32 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt32, rhs: UInt32
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: UInt32, rhs: UInt32) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: UInt32, rhs: UInt32) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: UInt32, rhs: UInt32) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// A 32-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct Int32
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int32


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int32(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: UInt32) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1132)
  @available(*, unavailable,
    message: "Please use Int32(bitPattern: UInt32) in combination with Float.bitPattern property.")
  public init(bitPattern x: Float) {
    Builtin.unreachable()
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int32 because it is either infinite or NaN")
    _precondition(source > -2147483904.0,
      "Float value cannot be converted to Int32 because the result would be less than Int32.min")
    _precondition(source < 2147483648.0,
      "Float value cannot be converted to Int32 because the result would be greater than Int32.max")
    self._value = Builtin.fptosi_FPIEEE32_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -2147483904.0 && source < 2147483648.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE32_Int32(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int32 because it is either infinite or NaN")
    _precondition(source > -2147483649.0,
      "Double value cannot be converted to Int32 because the result would be less than Int32.min")
    _precondition(source < 2147483648.0,
      "Double value cannot be converted to Int32 because the result would be greater than Int32.max")
    self._value = Builtin.fptosi_FPIEEE64_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -2147483649.0 && source < 2147483648.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE64_Int32(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int32 because it is either infinite or NaN")
    _precondition(source > -2147483649.0,
      "Float80 value cannot be converted to Int32 because the result would be less than Int32.min")
    _precondition(source < 2147483648.0,
      "Float80 value cannot be converted to Int32 because the result would be greater than Int32.max")
    self._value = Builtin.fptosi_FPIEEE80_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -2147483649.0 && source < 2147483648.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE80_Int32(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: Int32, rhs: Int32) -> Bool {
    return Bool(Builtin.cmp_eq_Int32(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: Int32, rhs: Int32) -> Bool {
    return Bool(Builtin.cmp_slt_Int32(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout Int32, rhs: Int32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout Int32, rhs: Int32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout Int32, rhs: Int32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout Int32, rhs: Int32) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int32)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1235)
    if _slowPath(
      lhs == Int32.min && rhs == (-1 as Int32)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.sdiv_Int32(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int32.min && other == (-1 as Int32)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int32.min && other == (-1 as Int32)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.srem_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout Int32, rhs: Int32) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int32)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1302)
    if _slowPath(lhs == Int32.min && rhs == (-1 as Int32)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.srem_Int32(lhs._value, rhs._value),
      false._value)
    lhs = Int32(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int32) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout Int32, rhs: Int32) {
    lhs = Int32(Builtin.and_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout Int32, rhs: Int32) {
    lhs = Int32(Builtin.or_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout Int32, rhs: Int32) {
    lhs = Int32(Builtin.xor_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout Int32, rhs: Int32) {
    let rhs_ = rhs & 31
    lhs = Int32(
      Builtin.ashr_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout Int32, rhs: Int32) {
    let rhs_ = rhs & 31
    lhs = Int32(
      Builtin.shl_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of a `Int32` instance is 32.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 32 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int32(
        Builtin.int_ctlz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int32(
        Builtin.int_cttz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int32(
        Builtin.int_ctpop_Int32(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int32.Words>

    @usableFromInline
    internal var _value: Int32

    @inlinable
    public init(_ value: Int32) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (32 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int32(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1447)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.sextOrBitCast_Int32_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int32(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt32

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1478)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @_transparent
  public var magnitude: UInt32 {
    let base = UInt32(_value)
    return self < (0 as Int32) ? ~base &+ 1 : base
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: Int32)
    -> (high: Int32, low: Int32.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.sext_Int32_Int64(self._value)
    let rhs_ = Builtin.sext_Int32_Int64(other._value)

    let res = Builtin.mul_Int64(lhs_, rhs_)
    let low = Int32.Magnitude(Builtin.truncOrBitCast_Int64_Int32(res))
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let shifted = Builtin.ashr_Int64(res, shift)
    let high = Int32(Builtin.truncOrBitCast_Int64_Int32(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: Int32, low: Int32.Magnitude)
  ) -> (quotient: Int32, remainder: Int32) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int32_Int64(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let lhsHighShifted = Builtin.shl_Int64(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int32_Int64(dividend.low._value)
    let lhs_ = Builtin.or_Int64(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int32_Int64(self._value)

    let quotient_ = Builtin.sdiv_Int64(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int64(lhs_, rhs_)

    let quotient = Int32(
      Builtin.truncOrBitCast_Int64_Int32(quotient_))
    let remainder = Int32(
      Builtin.truncOrBitCast_Int64_Int32(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: Int32 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return Int32(Builtin.int_bswap_Int32(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int32

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int32 { return 32 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int32 { return 32/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> Int32 {
    let isPositive = Int32(Builtin.zext_Int1_Int32(
      (self > (0 as Int32))._value))
    return isPositive | (self &>> 31)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension Int32 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt32(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1675)
    return Hasher._hash(
      seed: seed,
      bytes: UInt64(truncatingIfNeeded: UInt32(_value)),
      count: 4)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension Int32 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1711)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int32 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: Int32, rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int32, rhs: Int32
  ) -> Int32 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int32, rhs: Int32
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int32, rhs: Int32
  ) -> Int32 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int32, rhs: Int32
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: Int32, rhs: Int32) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: Int32, rhs: Int32) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: Int32, rhs: Int32) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1782)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@_transparent
public func _assumeNonNegative(_ x: Int32) -> Int32 {
  _internalInvariant(x >= (0 as Int32))
  return Int32(Builtin.assumeNonNegative_Int32(x._value))
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// A 64-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct UInt64
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt64


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: Int64) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt64 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt64 because the result would be less than UInt64.min")
    _precondition(source < 18446744073709551616.0,
      "Float value cannot be converted to UInt64 because the result would be greater than UInt64.max")
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 18446744073709551616.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt64 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt64 because the result would be less than UInt64.min")
    _precondition(source < 18446744073709551616.0,
      "Double value cannot be converted to UInt64 because the result would be greater than UInt64.max")
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 18446744073709551616.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt64 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt64 because the result would be less than UInt64.min")
    _precondition(source < 18446744073709551616.0,
      "Float80 value cannot be converted to UInt64 because the result would be greater than UInt64.max")
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 18446744073709551616.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: UInt64, rhs: UInt64) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: UInt64, rhs: UInt64) -> Bool {
    return Bool(Builtin.cmp_ult_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout UInt64, rhs: UInt64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout UInt64, rhs: UInt64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout UInt64, rhs: UInt64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout UInt64, rhs: UInt64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt64)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.udiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.udiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.urem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout UInt64, rhs: UInt64) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt64)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.urem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = UInt64(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout UInt64, rhs: UInt64) {
    lhs = UInt64(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout UInt64, rhs: UInt64) {
    lhs = UInt64(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout UInt64, rhs: UInt64) {
    lhs = UInt64(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout UInt64, rhs: UInt64) {
    let rhs_ = rhs & 63
    lhs = UInt64(
      Builtin.lshr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout UInt64, rhs: UInt64) {
    let rhs_ = rhs & 63
    lhs = UInt64(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of a `UInt64` instance is 64.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt64(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt64(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt64(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt64.Words>

    @usableFromInline
    internal var _value: UInt64

    @inlinable
    public init(_ value: UInt64) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt64(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.zextOrBitCast_Int64_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: UInt64)
    -> (high: UInt64, low: UInt64.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.zext_Int64_Int128(self._value)
    let rhs_ = Builtin.zext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = UInt64.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = UInt64(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: UInt64, low: UInt64.Magnitude)
  ) -> (quotient: UInt64, remainder: UInt64) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int64_Int128(self._value)

    let quotient_ = Builtin.udiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int128(lhs_, rhs_)

    let quotient = UInt64(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = UInt64(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: UInt64 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return UInt64(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt64 { return 64 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt64 { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> UInt64 {
    let isPositive = UInt64(Builtin.zext_Int1_Int64(
      (self > (0 as UInt64))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension UInt64 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt64(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1671)
    return Hasher._hash(seed: seed, UInt64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension UInt64 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt64 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: UInt64, rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt64, rhs: UInt64
  ) -> UInt64 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt64, rhs: UInt64
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt64, rhs: UInt64
  ) -> UInt64 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt64, rhs: UInt64
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: UInt64, rhs: UInt64) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: UInt64, rhs: UInt64) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: UInt64, rhs: UInt64) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1098)
/// A 64-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct Int64
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int64


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: UInt64) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1132)
  @available(*, unavailable,
    message: "Please use Int64(bitPattern: UInt64) in combination with Double.bitPattern property.")
  public init(bitPattern x: Double) {
    Builtin.unreachable()
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int64 because it is either infinite or NaN")
    _precondition(source > -9223373136366403584.0,
      "Float value cannot be converted to Int64 because the result would be less than Int64.min")
    _precondition(source < 9223372036854775808.0,
      "Float value cannot be converted to Int64 because the result would be greater than Int64.max")
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -9223373136366403584.0 && source < 9223372036854775808.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int64 because it is either infinite or NaN")
    _precondition(source > -9223372036854777856.0,
      "Double value cannot be converted to Int64 because the result would be less than Int64.min")
    _precondition(source < 9223372036854775808.0,
      "Double value cannot be converted to Int64 because the result would be greater than Int64.max")
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -9223372036854777856.0 && source < 9223372036854775808.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int64 because it is either infinite or NaN")
    _precondition(source > -9223372036854775809.0,
      "Float80 value cannot be converted to Int64 because the result would be less than Int64.min")
    _precondition(source < 9223372036854775808.0,
      "Float80 value cannot be converted to Int64 because the result would be greater than Int64.max")
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -9223372036854775809.0 && source < 9223372036854775808.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: Int64, rhs: Int64) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: Int64, rhs: Int64) -> Bool {
    return Bool(Builtin.cmp_slt_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout Int64, rhs: Int64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout Int64, rhs: Int64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout Int64, rhs: Int64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout Int64, rhs: Int64) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int64)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1235)
    if _slowPath(
      lhs == Int64.min && rhs == (-1 as Int64)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.sdiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int64.min && other == (-1 as Int64)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int64.min && other == (-1 as Int64)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.srem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout Int64, rhs: Int64) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int64)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1302)
    if _slowPath(lhs == Int64.min && rhs == (-1 as Int64)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.srem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = Int64(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout Int64, rhs: Int64) {
    lhs = Int64(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout Int64, rhs: Int64) {
    lhs = Int64(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout Int64, rhs: Int64) {
    lhs = Int64(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout Int64, rhs: Int64) {
    let rhs_ = rhs & 63
    lhs = Int64(
      Builtin.ashr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout Int64, rhs: Int64) {
    let rhs_ = rhs & 63
    lhs = Int64(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1346)
  /// The bit width of a `Int64` instance is 64.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int64(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int64(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int64(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int64.Words>

    @usableFromInline
    internal var _value: Int64

    @inlinable
    public init(_ value: Int64) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int64(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1447)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.sextOrBitCast_Int64_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1478)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @_transparent
  public var magnitude: UInt64 {
    let base = UInt64(_value)
    return self < (0 as Int64) ? ~base &+ 1 : base
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: Int64)
    -> (high: Int64, low: Int64.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.sext_Int64_Int128(self._value)
    let rhs_ = Builtin.sext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = Int64.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = Int64(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: Int64, low: Int64.Magnitude)
  ) -> (quotient: Int64, remainder: Int64) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int64_Int128(self._value)

    let quotient_ = Builtin.sdiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int128(lhs_, rhs_)

    let quotient = Int64(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = Int64(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: Int64 {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return Int64(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int64 { return 64 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int64 { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> Int64 {
    let isPositive = Int64(Builtin.zext_Int1_Int64(
      (self > (0 as Int64))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension Int64 : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt64(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1671)
    return Hasher._hash(seed: seed, UInt64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension Int64 : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int64 {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: Int64, rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int64, rhs: Int64
  ) -> Int64 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int64, rhs: Int64
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int64, rhs: Int64
  ) -> Int64 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int64, rhs: Int64
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: Int64, rhs: Int64) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: Int64, rhs: Int64) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: Int64, rhs: Int64) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1782)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@_transparent
public func _assumeNonNegative(_ x: Int64) -> Int64 {
  _internalInvariant(x >= (0 as Int64))
  return Int64(Builtin.assumeNonNegative_Int64(x._value))
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1093)
/// An unsigned integer value type.
///
/// On 32-bit platforms, `UInt` is the same size as `UInt32`, and
/// on 64-bit platforms, `UInt` is the same size as `UInt64`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct UInt
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: Int) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt because the result would be less than UInt.min")
    _precondition(source < 18446744073709551616.0,
      "Float value cannot be converted to UInt because the result would be greater than UInt.max")
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 18446744073709551616.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt because the result would be less than UInt.min")
    _precondition(source < 18446744073709551616.0,
      "Double value cannot be converted to UInt because the result would be greater than UInt.max")
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 18446744073709551616.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt because the result would be less than UInt.min")
    _precondition(source < 18446744073709551616.0,
      "Float80 value cannot be converted to UInt because the result would be greater than UInt.max")
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -1.0 && source < 18446744073709551616.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: UInt, rhs: UInt) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: UInt, rhs: UInt) -> Bool {
    return Bool(Builtin.cmp_ult_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout UInt, rhs: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout UInt, rhs: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout UInt, rhs: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout UInt, rhs: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.udiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.udiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.urem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout UInt, rhs: UInt) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.urem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = UInt(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout UInt, rhs: UInt) {
    lhs = UInt(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout UInt, rhs: UInt) {
    lhs = UInt(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout UInt, rhs: UInt) {
    lhs = UInt(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout UInt, rhs: UInt) {
    let rhs_ = rhs & 63
    lhs = UInt(
      Builtin.lshr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout UInt, rhs: UInt) {
    let rhs_ = rhs & 63
    lhs = UInt(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1343)
  /// The bit width of a `UInt` instance is 32 on 32-bit
  /// platforms and 64 on 64-bit platforms.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt.Words>

    @usableFromInline
    internal var _value: UInt

    @inlinable
    public init(_ value: UInt) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.zextOrBitCast_Int64_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: UInt)
    -> (high: UInt, low: UInt.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.zext_Int64_Int128(self._value)
    let rhs_ = Builtin.zext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = UInt.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = UInt(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: UInt, low: UInt.Magnitude)
  ) -> (quotient: UInt, remainder: UInt) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int64_Int128(self._value)

    let quotient_ = Builtin.udiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int128(lhs_, rhs_)

    let quotient = UInt(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = UInt(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return UInt(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1610)
  @_transparent
  public // @testable
  init(_ _v: Builtin.Word) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1616)
    self._value = Builtin.zextOrBitCast_Word_Int64(_v)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1618)
  }

  @_transparent
  public // @testable
  var _builtinWordValue: Builtin.Word {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1626)
    return Builtin.truncOrBitCast_Int64_Word(_value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1628)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt { return 64 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> UInt {
    let isPositive = UInt(Builtin.zext_Int1_Int64(
      (self > (0 as UInt))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension UInt : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1671)
    return Hasher._hash(seed: seed, UInt64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension UInt : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1709)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension UInt {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1709)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: UInt, rhs: UInt) -> UInt {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt, rhs: UInt
  ) -> UInt {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt, rhs: UInt
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt, rhs: UInt
  ) -> UInt {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt, rhs: UInt
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: UInt, rhs: UInt) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: UInt, rhs: UInt) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: UInt, rhs: UInt) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1090)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1093)
/// A signed integer value type.
///
/// On 32-bit platforms, `Int` is the same size as `Int32`, and
/// on 64-bit platforms, `Int` is the same size as `Int64`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1101)
@_fixed_layout
public struct Int
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int


  @_transparent
  public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
    _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @_transparent
  public init(bitPattern x: UInt) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1138)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int because it is either infinite or NaN")
    _precondition(source > -9223373136366403584.0,
      "Float value cannot be converted to Int because the result would be less than Int.min")
    _precondition(source < 9223372036854775808.0,
      "Float value cannot be converted to Int because the result would be greater than Int.max")
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -9223373136366403584.0 && source < 9223372036854775808.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int because it is either infinite or NaN")
    _precondition(source > -9223372036854777856.0,
      "Double value cannot be converted to Int because the result would be less than Int.min")
    _precondition(source < 9223372036854775808.0,
      "Double value cannot be converted to Int because the result would be greater than Int.max")
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Double) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -9223372036854777856.0 && source < 9223372036854775808.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1142)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1144)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1146)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int because it is either infinite or NaN")
    _precondition(source > -9223372036854775809.0,
      "Float80 value cannot be converted to Int because the result would be less than Int.min")
    _precondition(source < 9223372036854775808.0,
      "Float80 value cannot be converted to Int because the result would be greater than Int.max")
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @_transparent
  public init?(exactly source: Float80) {
    // The value passed as `source` must not be infinite, NaN, or exceed the
    // bounds of the integer type; the result of `fptosi` or `fptoui` is
    // undefined if it overflows.
    guard source > -9223372036854775809.0 && source < 9223372036854775808.0 else {
      return nil
    }
    guard source == source.rounded(.towardZero) else {
      return nil
    }
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1207)
#endif
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1209)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1211)

  @_transparent
  public static func == (lhs: Int, rhs: Int) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @_transparent
  public static func < (lhs: Int, rhs: Int) -> Bool {
    return Bool(Builtin.cmp_slt_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func +=(lhs: inout Int, rhs: Int) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func -=(lhs: inout Int, rhs: Int) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func *=(lhs: inout Int, rhs: Int) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1246)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1224)

  @_transparent
  public static func /=(lhs: inout Int, rhs: Int) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1228)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1235)
    if _slowPath(
      lhs == Int.min && rhs == (-1 as Int)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1242)
    let (result, overflow) =
      (Builtin.sdiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1250)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1254)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func dividedReportingOverflow(
    by other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int.min && other == (-1 as Int)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1263)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1269)
    if _slowPath(self == Int.min && other == (-1 as Int)) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1271)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1274)

    let (newStorage, overflow) = (
      Builtin.srem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func addingReportingOverflow(
    _ other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1256)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1257)

  @_transparent
  public func multipliedReportingOverflow(
    by other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1280)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1285)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1291)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and has a magnitude less than
  /// `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1292)

  @_transparent
  public static func %=(lhs: inout Int, rhs: Int) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1302)
    if _slowPath(lhs == Int.min && rhs == (-1 as Int)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1307)

    let (newStorage, _) = (
      Builtin.srem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = Int(newStorage)
  }

  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func &=(lhs: inout Int, rhs: Int) {
    lhs = Int(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func |=(lhs: inout Int, rhs: Int) {
    lhs = Int(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1320)

  @_transparent
  public static func ^=(lhs: inout Int, rhs: Int) {
    lhs = Int(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1326)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &>>=(lhs: inout Int, rhs: Int) {
    let rhs_ = rhs & 63
    lhs = Int(
      Builtin.ashr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1328)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1329)

  @_transparent
  public static func &<<=(lhs: inout Int, rhs: Int) {
    let rhs_ = rhs & 63
    lhs = Int(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1338)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1343)
  /// The bit width of a `Int` instance is 32 on 32-bit
  /// platforms and 64 on 64-bit platforms.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1348)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  /// A type that represents the words of this integer.
  @_fixed_layout
  public struct Words : RandomAccessCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int.Words>

    @usableFromInline
    internal var _value: Int

    @inlinable
    public init(_ value: Int) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1447)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1451)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1460)
    return UInt(
      Builtin.sextOrBitCast_Int64_Int64(_value)
    )
  }

  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1469)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1478)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @_transparent
  public var magnitude: UInt {
    let base = UInt(_value)
    return self < (0 as Int) ? ~base &+ 1 : base
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1499)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1501)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable
  public func multipliedFullWidth(by other: Int)
    -> (high: Int, low: Int.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1538)
    let lhs_ = Builtin.sext_Int64_Int128(self._value)
    let rhs_ = Builtin.sext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = Int.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = Int(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1548)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable
  public func dividingFullWidth(
    _ dividend: (high: Int, low: Int.Magnitude)
  ) -> (quotient: Int, remainder: Int) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1574)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int64_Int128(self._value)

    let quotient_ = Builtin.sdiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int128(lhs_, rhs_)

    let quotient = Int(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = Int(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1593)
  }

  /// A representation of this integer with the byte order swapped.
  @_transparent
  public var byteSwapped: Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1601)
    return Int(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1603)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1610)
  @_transparent
  public // @testable
  init(_ _v: Builtin.Word) {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1616)
    self._value = Builtin.sextOrBitCast_Word_Int64(_v)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1618)
  }

  @_transparent
  public // @testable
  var _builtinWordValue: Builtin.Word {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1626)
    return Builtin.truncOrBitCast_Int64_Word(_value)
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1628)
  }
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1630)

  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int { return 64 }

  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable
  @inline(__always)
  public func signum() -> Int {
    let isPositive = Int(Builtin.zext_Int1_Int64(
      (self > (0 as Int))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1656)

extension Int : Hashable {
  /// Hashes the essential components of this value by feeding them into the
  /// given hasher.
  ///
  /// - Parameter hasher: The hasher to use when combining the components
  ///   of this instance.
  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher._combine(UInt(_value))
  }

  @inlinable
  public func _rawHashValue(seed: Int) -> Int {
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1671)
    return Hasher._hash(seed: seed, UInt64(_value))
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1680)
  }
}

extension Int : _HasCustomAnyHashableRepresentation {
  // Not @inlinable
  public func _toCustomAnyHashable() -> AnyHashable? {
    return AnyHashable(_box: _IntegerAnyHashableBox(self))
  }
}

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1709)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1695)
extension Int {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1709)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1713)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1718)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int {

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func |(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func ^(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &>>(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func &<<(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func /(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the remainder operator (`%`) has the same sign as `lhs` and
  /// has a magnitude less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func %(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func +(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func -(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1727)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1728)

  @_transparent
  public static func *(lhs: Int, rhs: Int) -> Int {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1737)

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int, rhs: Int
  ) -> Int {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int, rhs: Int
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1739)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and wrap the result in case
  /// of any overflow, use the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1740)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int, rhs: Int
  ) -> Int {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1752)

  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int, rhs: Int
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1763)

  @_transparent
  public static func <= (lhs: Int, rhs: Int) -> Bool {
    return !(rhs < lhs)
  }

  @_transparent
  public static func >= (lhs: Int, rhs: Int) -> Bool {
    return !(lhs < rhs)
  }

  @_transparent
  public static func > (lhs: Int, rhs: Int) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1782)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@_transparent
public func _assumeNonNegative(_ x: Int) -> Int {
  _internalInvariant(x >= (0 as Int))
  return Int(Builtin.assumeNonNegative_Int64(x._value))
}
// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1791)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/frain/Local/swift-source/swift/stdlib/public/core/IntegerTypes.swift.gyb", line: 1795)

extension Int {
  // FIXME(ABI): using Int as the return type is wrong.
  /// Returns the distance from this value to the given value, expressed as a
  /// stride.
  ///
  /// For two values `x` and `y`, and a distance `n = x.distance(to: y)`,
  /// `x.advanced(by: n) == y`.
  ///
  /// - Parameter other: The value to calculate the distance to.
  /// - Returns: The distance from this value to `other`.
  @_transparent
  public func distance(to other: Int) -> Int {
    return other - self
  }

  // FIXME(ABI): using Int as the parameter type is wrong.
  /// Returns a value that is offset the specified distance from this value.
  ///
  /// Use the `advanced(by:)` method in generic code to offset a value by a
  /// specified distance. If you're working directly with numeric values, use
  /// the addition operator (`+`) instead of this method.
  ///
  /// For a value `x`, a distance `n`, and a value `y = x.advanced(by: n)`,
  /// `x.distance(to: y) == n`.
  ///
  /// - Parameter n: The distance to advance this value.
  /// - Returns: A value that is offset from this value by `n`.
  @_transparent
  public func advanced(by n: Int) -> Int {
    return self + n
  }
}

// FIXME(integers): switch to using `FixedWidthInteger.unsafeAdding`
@_transparent
@inlinable
internal func _unsafePlus(_ lhs: Int, _ rhs: Int) -> Int {
#if INTERNAL_CHECKS_ENABLED
  return lhs + rhs
#else
  return lhs &+ rhs
#endif
}

// FIXME(integers): switch to using `FixedWidthInteger.unsafeSubtracting`
@_transparent
@inlinable
internal func _unsafeMinus(_ lhs: Int, _ rhs: Int) -> Int {
#if INTERNAL_CHECKS_ENABLED
  return lhs - rhs
#else
  return lhs &- rhs
#endif
}

internal struct _IntegerAnyHashableBox<
  Base: FixedWidthInteger
>: _AnyHashableBox {
  internal let _value: Base

  internal init(_ value: Base) {
    self._value = value
  }

  internal var _canonicalBox: _AnyHashableBox {
    // We need to follow NSNumber semantics here; the AnyHashable forms of
    // integer types holding the same mathematical value should compare equal.
    // Sign-extend value to a 64-bit integer. This will generate hash conflicts
    // between, say -1 and UInt.max, but that's fine.
    if _value < 0 {
      return _IntegerAnyHashableBox<Int64>(Int64(truncatingIfNeeded: _value))
    }
    return _IntegerAnyHashableBox<UInt64>(UInt64(truncatingIfNeeded: _value))
  }

  internal func _isEqual(to box: _AnyHashableBox) -> Bool? {
    if Base.self == UInt64.self {
      guard let box = box as? _IntegerAnyHashableBox<UInt64> else { return nil }
      return _value == box._value
    }
    if Base.self == Int64.self {
      guard let box = box as? _IntegerAnyHashableBox<Int64> else { return nil }
      return _value == box._value
    }
    _preconditionFailure("self isn't canonical")
  }

  internal var _hashValue: Int {
    _internalInvariant(Base.self == UInt64.self || Base.self == Int64.self,
      "self isn't canonical")
    return _value.hashValue
  }

  internal func _hash(into hasher: inout Hasher) {
    _internalInvariant(Base.self == UInt64.self || Base.self == Int64.self,
      "self isn't canonical")
    _value.hash(into: &hasher)
  }

  internal func _rawHashValue(_seed: Int) -> Int {
    _internalInvariant(Base.self == UInt64.self || Base.self == Int64.self,
      "self isn't canonical")
    return _value._rawHashValue(seed: _seed)
  }

  internal var _base: Any {
    return _value
  }

  internal func _unbox<T: Hashable>() -> T? {
    return _value as? T
  }

  internal func _downCastConditional<T>(
    into result: UnsafeMutablePointer<T>
  ) -> Bool {
    guard let value = _value as? T else { return false }
    result.initialize(to: value)
    return true
  }
}

// Local Variables:
// eval: (read-only-mode 1)
// End:
