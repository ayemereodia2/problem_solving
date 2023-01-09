import UIKit

// convert Int to Roman Numeral strings
// Hint: It a recursive solution with a base case of input == 1 or 0 return "I"
// Place all special cases in a key value Dictionary or HashMap for a constant look up
// create a result variable of type string
// else using the lower part of the range (e.g (1...4) || (5...9))
// check if number is contained in the range
// check the Dictionary if number is a stored value and return
// find the modulos of the input Int % with the lower part of the range
// if modulos is zero, use the quotient of the number lower part of the range
// the quotient is used create a loop that starts from 0..<quotient
// within the loop make a recursive call to the main method passing the lower range as input and appending the result to the result variable
// if modulos is not zero, make a recursive call to main method passing a difference of number and remainder  add the result to another recursive call to main method and remainder, assign the sum to main result string variable.

// return the final result

class Solution {
    func intToRoman(_ num: Int) -> String {
        var result = ""
        let numz = num
        if numz == 1 || numz == 0 {
            result = "I"
            return result
        } else if (1...4).contains(numz) {
            if let val = returnSpecialNumeral(num: numz) {
                result = val
                return result
            }
            
            for index in 0..<numz {
                result += intToRoman(index % 1)
            }
            
        } else if (5...9).contains(numz) {
          return checkRange(begin: 5, num: numz)
        } else if (10...49).contains(numz) {
          return checkRange(begin: 10, num: numz)
        }else if (50...89).contains(numz) {
           return checkRange(begin: 50, num: numz)
        }else if (90...99).contains(numz){
            return checkRange(begin: 90, num: numz)
        }
        else if (100...499).contains(numz) {
            return checkRange(begin: 100, num: numz)
        }else if (500...899).contains(numz) {
            return checkRange(begin: 500, num: numz)
        }else if (900...999).contains(numz) {
            return checkRange(begin: 900, num: numz)
        }
        else if (1000...4999).contains(numz) {
            return checkRange(begin: 1000, num: numz)
        }

       return result
    }

    func checkRange(begin: Int, num:Int) -> String {
        var result = ""
            if let val = returnSpecialNumeral(num: num) {
                result = val
                return result
            }

            let remainder = num % begin
            if remainder == 0 {
                let divisor = Int(num / begin)

                for _ in 0..<divisor {
                    result += intToRoman(begin)
                }

            } else {
                result = intToRoman(num - remainder) + intToRoman(remainder)
            }
        return result
    }

  func returnSpecialNumeral(num: Int) -> String? {
    let store = [1:"I", 5 : "V", 10: "X", 50 : "L", 100:"C", 500:"D", 1000:"M", 4:"IV", 9:"IX", 40:"XL", 90:"XC", 400:"CD", 900:"CM"]

        if let value = store[num] {
            return value
        }
      
        return nil
    }
}
// BigO is a function of input size. ON
class Solutionv {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var remainingFuel = 0
        var startIndex = -1
    
        for (index, costValue) in cost.enumerated() {
            let totalFuel = (remainingFuel + gas[index])
            if totalFuel >= costValue {
                
                remainingFuel = totalFuel - costValue
                if index == (cost.count - 1) && remainingFuel >= 0 {
                    if startIndex < index {
                        startIndex = index
                    }
                    
                    return startIndex
                }

            } else {
                startIndex = -1
                continue
            }
            
            startIndex = index
        }
    
    return -1
}
}
