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
// GAS STATION
// Can Complete Circuit using gas
// Hint:- Keep a controlIndex starting from zero, remainingFuel, totalFuel variable
// Looping from left to right using the cost array since both arrays are equal
// within the first loop, find calculate the totalFuel = sum of remainingFuel and gas using the controlIndex

// within the first loop
// check if totalFuel >= cost[controlIndex]
// keep that startIndex
// then subtract the totalFuel from the cost[i] and assign to remainingFuel variable (remainingFuel = totalFuel - cost[i])
//  within the main loop, create the a while loop to check where totalFuel >= cost[controlIndex]

class SolutionV {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var remainingFuel = 0
        var controlIndex = 0
        var indez = 0
        var startIndex = 0

        var totalFuel = 0

        if gas.count ==  1 && cost.count == 1 {
            if gas[0] >= cost[0] {
                return 0
            } else {
                return -1
            }
        }
        
        for (_, costValue) in cost.enumerated() {
            totalFuel = (remainingFuel + gas[controlIndex])
            
            if totalFuel >= cost[controlIndex] {
                startIndex = controlIndex
                remainingFuel = totalFuel - costValue
            
                while totalFuel >= cost[controlIndex] {
                    indez += 1
                    remainingFuel = totalFuel - cost[controlIndex]
                    
                    if (cost.count - 1) != controlIndex {
                        controlIndex += 1
                    } else {
                        controlIndex = 0
                    }
                    
                    totalFuel = (remainingFuel + gas[controlIndex])
                    
                    if indez == cost.count - 1 && totalFuel >= cost[controlIndex] {
                        return startIndex
                    }
                }

                if controlIndex == cost.count - 1 {
                    return -1
                }

                indez = 0
                

            } else {
                controlIndex += 1
                remainingFuel = 0
                continue
            }
        
        }
    
    return -1
}
}

let res = SolutionV()

 // res.canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2])
//  res.canCompleteCircuit([2,3,4], [3,4,3])
//  res.canCompleteCircuit([4,3,8,6,5], [5,8,4,7,7])

 // res.canCompleteCircuit([4,3,8,6,5], [5,8,4,7,7])

//res.canCompleteCircuit([5,1,2,3,4], [4,4,1,5,1])

//res.canCompleteCircuit([3,3,4], [3,4,4])

//res.canCompleteCircuit([5], [4])


//res.canCompleteCircuit([5,0,9,4,3,3,9,9,1,2], [6,7,5,9,5,8,7,1,10,5])
let gas = [67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66]

let cost = [27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]


//res.canCompleteCircuit(gas, cost)

// The Three Sum problem
// with a Brute force solution of bigO of N3
// HINT: Use 3 nested for loops
// loop 1 should start from index 0
// loop 2 from index 1
// loop 2 from index 2
// within the 3rd loop sum up the array element found in index 0 to 2 that is equal to zero.
// use a set of array to keep track of any unique values before appending to a final result output.

class SolutionQ {
    
    var result = 0
    var result2 = 0
   
    var arrResult = [[Int]]()
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count == 3 {
            result = nums.reduce(0, +)
            
            if result == 0 {
                arrResult.append(nums)
                return arrResult
            } else {
                return []
            }
        } else if nums.count < 3 {
            return []
        }
        
        var arrResult = [[Int]]()
        var uniqueSet = Set<[Int]>()
        
        for i in 0..<nums.count {
            
            for j in i + 1..<nums.count {
                
                for k in j + 1..<nums.count {
                    print("\(i) \(j) \(k)")
                    if nums[i] + nums[j] + nums[k] == 0 {
                        let ar = [nums[i], nums[j], nums[k]].sorted()
                        if !uniqueSet.contains(ar) {
                            uniqueSet.insert(ar)
                            arrResult.append(ar)
                        } else {
                            continue
                        }
                    }
                }
            }
        }
        
        return arrResult
    }
    
    // 3 sum using improved solution of Big 02
    // Hint: 
    
    func threeSumImpr(_ nums: [Int]) -> [[Int]] {
        if nums.count == 3 {
            result = nums.reduce(0, +)
            
            if result == 0 {
                arrResult.append(nums)
                return arrResult
            } else {
                return []
            }
        } else if nums.count < 3 {
            return []
        }
        
        var arrResult = [[Int]]()
        var uniqueSetx = Set<[Int]>()
        for i in 0..<nums.count {
            var uniqueSet = Set<Int>()

            for j in i + 1..<nums.count {
                
                let x = -(nums[i] + nums[j])
                
                if uniqueSet.contains(x) {
                    let ar = [x,nums[i], nums[j]].sorted()
                    if !uniqueSetx.contains(ar) {
                        uniqueSetx.insert(ar)
                        arrResult.append(ar)
                    } else {
                        continue
                    }
                   
                } else {
                    uniqueSet.insert(nums[j])
                }
            }
        }
        
        return arrResult
    }
}

let des = SolutionQ()
//print(des.threeSum([1,-1,-1,0]))
//print(des.threeSumImpr([1, -2, 1, 0, 5]))
//print(des.threeSum([-1,0,1,2,-1,-4]))
//print(des.threeSumImpr([-1,0,1,2,-1,-4,-2,-3,3,0,4]))

//print(ar.count)

func printTriplets() {
    let ar = [1,2,3]

    for i in 0..<ar.count {
        for j in i + 1..<ar.count {
            for k in j + 1..<ar.count {
                print("\(i) \(j) \(k)")
            }
        }
    }
}

// 3SUM closest

class SolutionS {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        // if sum > 0 keep track of least distance between sum - traget
        // if sum < 0 keep track of most distance between sum - target
        
        for i in 0..<nums.count {
            for j in i + 1..<nums.count {
                for k in j + 1..<nums.count {
                    print("\(nums[i]) \(nums[j]) \(nums[k])")
                }
            }
        }
        
        return 0
    }
}

let solution = SolutionS()

solution.threeSumClosest([-1, 2, 1,-4], 1)
