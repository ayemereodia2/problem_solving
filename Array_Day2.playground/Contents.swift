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
    // Hint: Use two for loops.
    // loop 1 should begin from 0 -> n - 1,
    // loop 2 begin from 1 -> n - 1
    // within loop 1, create a Set
    // within loop 2 find a sum of -(num[i] + num[j]) = set to variable x
    // check if x is in Set. If it contains, create and sort a new array of [x,num[i], num[j]]
    // Use another Set of interger arrays to track of unique Sum that is equal to Zero.
    // if x is not in Set, insert num[j] into Set.
    //Dictionary to store
    
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

func printQuadruplets() {
    let ar = [1,2,3,4]

    for i in 0..<ar.count {
        for j in i + 1..<ar.count {
            for k in j + 1..<ar.count {
                for l in k + 1..<ar.count {
                    print("\(i) \(j) \(k) \(l)")
                }
            }
        }
    }
}

//printQuadruplets()

// 3SUM closest to target
// HINT: create a func to track the DISTANCE between calculated sum of triplet and target abs(sum - target)
// use three for loops to calculate the sum
// Big O(n3)
// Space O(1)
class SolutionS {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        
        guard nums.count > 2 else { return 0 }
        
        let firstTripletSum = nums[0] + nums[1] + nums[2]
        var initialDistance = distanceBetween(sum: firstTripletSum, target: target)
        var nSum = firstTripletSum
        
        for i in 0..<nums.count {
            for j in i + 1..<nums.count {
                for k in j + 1..<nums.count {
                   let sum = nums[i] + nums[j] + nums[k]
                    
                    let result = distanceBetween(sum: sum, target: target)
                    
                    if result < initialDistance {
                        initialDistance = result
                        nSum = sum
                    }
                    
                }
            }
        }
        
        return nSum
    }
    
    func distanceBetween(sum: Int, target: Int) -> Int {
        abs(sum - target)
    }
    
    // HINT: - Sort the array in ascending order,
    // then use a for loop to move from left to right
    // Use Two Pointers. ptr1 is on the next index i + 1
    // pt2 is on the last index nums.count - 1
    // use a while ptr1 < ptr2, calculate sum = nums[i] + nums[ptr1] + nums[prt2]
    // if abs(target - sum) < abs(target - closest)
    // set closest = sum
    // and if sum > target decrement ptr2 to the left by 1
    // else increment ptr1 to the right
    func threeSumClosestImprove(_ nums: [Int], _ target: Int) -> Int {
        
        guard nums.count > 2 else { return 0 }
        
        let sortedNums = nums.sorted()
        
        let firstTripletSum = sortedNums[0] + sortedNums[1] + sortedNums[2]
        var nSum = firstTripletSum
                
        for i in 0..<sortedNums.count {
            var ptr1 = i + 1
            var ptr2 = sortedNums.count - 1
            
            while(ptr1 < ptr2) {
                
                let sum = sortedNums[i] + sortedNums[ptr1] + sortedNums[ptr2]
                let x = abs(target - sum)
                let y = abs(target - nSum)
                
                if x < y {
                    
                    nSum = sum
                }
                
                if sum > target {
                    ptr2 -= 1
                } else {
                    ptr1 += 1
                }
                
            }
        }
        
        return nSum
    }
}

let solution = SolutionS()

//print(solution.threeSumClosestImprove([1, 1, 1,0], -100))
//print(solution.threeSumClosest([-1, 2, 1,-4], 1))
//print(solution.threeSumClosest([4, 0, 5,-5,3,3,0,-4,-5, -2], -2))
//print(solution.threeSumClosest([0, 0,0], 0))
let big1 = [40,-53,36,89,-38,-51,80,11,-10,76,-30,46,-39,-15,4,72,83,-25,33,-69,-73,-100,-23,-37,-13,-62,-26,-54,36,-84,-65,-51,11,98,-21,49,51,78,-58,-40,95,-81,41,-17,-70,83,-88,-14,-75,-10,-44,-21,6,68,-81,-1,41,-61,-82,-24,45,19,6,-98,11,9,-66,50,-97,-2,58,17,51,-13,88,-16,-77,31,35,98,-2,0,-70,6,-34,-8,78,22,-1,-93,-39,-88,-77,-65,80,91,35,-15,7,-37,-96,65,3,33,-22,60,1,76,-32,22]

//print(solution.threeSumClosestImprove(big1, 292))

// 4SUM to Target
// Brute force solution Big O(n4)
// Hint:
class SolutionY {
    var result = 0
    var arrResult = [[Int]]()
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count == 4 {
            result = nums.reduce(0, +)
            
            if result == target {
                arrResult.append(nums)
                return arrResult
            } else {
                return []
            }
        } else if nums.count < 4 {
            return []
        }
        
        var arrResult = [[Int]]()
        var uniqueSet = Set<[Int]>()
        
        for i in 0..<nums.count {
            
            for j in i + 1..<nums.count {
                
                for k in j + 1..<nums.count {
                    
                    for l in k + 1..<nums.count {
                        if nums[i] + nums[j] + nums[k] + nums[l] == target {
                            let ar = [nums[i], nums[j], nums[k], nums[l]].sorted()
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
        }
        
        return arrResult
    }
    
    func fourSumImprove(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count == 4 {
            result = nums.reduce(0, +)
            
            if result == target {
                arrResult.append(nums)
                return arrResult
            } else {
                return []
            }
        } else if nums.count < 4 {
            return []
        }
        
        var arrResult = [[Int]]()
        var uniqueSet = Set<[Int]>()
        
        for i in 0..<nums.count {
            
            for j in i + 1..<nums.count {
                
            }
        }
        
        return arrResult
    }
}

//let some = SolutionY()

//print(some.fourSumImprove([1,0,-1,0,-2,2], 0))
//print(some.fourSumImprove([2,2,2,2,2], 8))

//let ar = [1,2,3]
//for i in 0..<ar.count {
//    
//}

class SolutionL {
    
    func nextPermutation(_ nums: inout [Int]) {
     //rethinking the solution to next permutation problem
        let arrayInt = convertToInt(nums)
        let counted = nums.count
        var least = Int.max
        var j = 1
        var i = 0
        
        for _ in nums  {
             
            while j < counted {
                
                var removed = nums.remove(at: i)
                nums.insert(removed, at: j)
                print(nums)
                let convertedInt = convertToInt(nums)
                if convertedInt == arrayInt {
                    j += 1
                    i += 1
                    continue }
                
                if convertedInt < least && convertedInt > arrayInt {
                    least = convertedInt
                }
                
                j += 1
                i += 1
                
            }
            
            j = 1
            i = 0
        }
        

        if least == Int.max {
            nums = nums.sorted(by: <)
        } else {
            nums = convertToArray(least)
            if nums.count != counted {
                nums.insert(0, at: 0)
            }
        }
       
    }
    
    func convertToInt(_ myArray: [Int]) -> Int {
        var myString = ""
        _ = myArray.map{ myString = myString + "\($0)" }
        return Int(myString)!
    }
    
    func convertToArray(_ num: Int) -> [Int] {
        let array = String(num).compactMap({$0.wholeNumberValue})
        return array
    }
}


let perm = SolutionL()

var arr = [5,4,7,5,3,2]
//var removed = arr.remove(at: 1)
perm.nextPermutation(&arr)

//print(arr.insert(removed, at: 2))
//print(arr)
