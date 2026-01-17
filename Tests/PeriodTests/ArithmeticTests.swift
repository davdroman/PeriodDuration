import Period
import XCTest

final class ArithmeticTests: XCTestCase {
	// MARK: - Unary

	func testUnaryPlus() {
		XCTAssertEqual(+Period.zero, Period.zero)
		XCTAssertEqual(+Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6), Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
		XCTAssertEqual(+Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6), Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
	}

	func testUnaryMinus() {
		XCTAssertEqual(-Period.zero, Period.zero)
		XCTAssertEqual(-Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6), Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
		XCTAssertEqual(-Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6), Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
	}

	// MARK: - Addition

	func testAddition() {
		let a = Period(years: 1, months: 2, days: 3)
		let b = Period(years: 4, months: 5, days: 6)
		XCTAssertEqual(a + b, Period(years: 5, months: 7, days: 9))
	}

	func testAdditionWithTime() {
		let a = Period(hours: 1, minutes: 30)
		let b = Period(hours: 2, minutes: 45)
		XCTAssertEqual(a + b, Period(hours: 3, minutes: 75))
	}

	func testAdditionCompoundAssignment() {
		var period = Period(years: 1)
		period += Period(months: 6)
		XCTAssertEqual(period, Period(years: 1, months: 6))
	}

	func testAdditionWithZero() {
		let period = Period(years: 1, months: 2)
		XCTAssertEqual(period + .zero, period)
		XCTAssertEqual(.zero + period, period)
	}

	// MARK: - Subtraction

	func testSubtraction() {
		let a = Period(years: 5, months: 7, days: 9)
		let b = Period(years: 1, months: 2, days: 3)
		XCTAssertEqual(a - b, Period(years: 4, months: 5, days: 6))
	}

	func testSubtractionResultingInNegative() {
		let a = Period(years: 1)
		let b = Period(years: 3)
		XCTAssertEqual(a - b, Period(years: -2))
	}

	func testSubtractionCompoundAssignment() {
		var period = Period(years: 5, months: 3)
		period -= Period(months: 1)
		XCTAssertEqual(period, Period(years: 5, months: 2))
	}

	func testSubtractionFromZero() {
		let period = Period(years: 1, months: 2)
		XCTAssertEqual(.zero - period, -period)
	}

	// MARK: - Scalar Multiplication

	func testMultiplicationByPositive() {
		let period = Period(years: 1, months: 2, days: 3)
		XCTAssertEqual(period * 2, Period(years: 2, months: 4, days: 6))
	}

	func testMultiplicationByZero() {
		let period = Period(years: 1, months: 2, days: 3)
		XCTAssertEqual(period * 0, .zero)
	}

	func testMultiplicationByNegative() {
		let period = Period(years: 1, months: 2)
		XCTAssertEqual(period * -1, Period(years: -1, months: -2))
	}

	func testMultiplicationCommutative() {
		let period = Period(hours: 5, minutes: 30)
		XCTAssertEqual(period * 3, 3 * period)
	}

	func testMultiplicationCompoundAssignment() {
		var period = Period(days: 7)
		period *= 4
		XCTAssertEqual(period, Period(days: 28))
	}

	// MARK: - Negation

	func testNegate() {
		var period = Period(years: 1, months: -2, days: 3)
		period.negate()
		XCTAssertEqual(period, Period(years: -1, months: 2, days: -3))
	}
}
