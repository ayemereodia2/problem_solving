import UIKit

// Container With Most Water Problem
// Given an Int array input of height of length N. There are N vertical lines drawn such that the
// two endpoints of ith line are (i,0) (i, height[i])
// find the two lines that together with the X-axis form a container, such that the container contains most water.
// return the maximum amount of water a container can store.

// Hint this problem has nothing to do with Water.
// Area = min(h1,h2) * width
// where width is 1 unit from each height

// we take min of two heights since any water over the minimum height will spill over and therefore
// cannot be held by the container

//BRUTE FORCE SOLUTION 1

class Solution {
    // Big O of N2 // because loop 1 is O(N * (N - 1)) = (N2 - N)
    // ignoring the least dorminant term Big O is N2
    func maxArea(_ height: [Int]) -> Int {
        var maxi = 0
        for index in 0..<height.count {
            let start = index + 1
            
            for innerIndex in start..<height.count {
                var distance = innerIndex - index
                let result = min(height[index], height[innerIndex])  * distance
                maxi = max(result, maxi)
            }
        }
        
        return maxi
    }
    // A more efficient solution
    // By observing the brute force solution above
    // You'd observe theres an unnessary calculation of Area when min(height1 < height2) * distance, as distance reduces from the right to left of the array.
    // the only Area calculation that matters is the from the farthest right end of the array.
    // so we make use of a two pointers to track the left and right values
    // if a left value is less than a right value we increment a left pointer by one to the right
    // else we decrement a right pointer to the left
    //
    func maxAreaEf(_ height: [Int]) -> Int {
        var maxi = 0
        var l = 0
        var r = height.count
        while l < r {
            var distance = r - l
            let result = min(height[l], height[r])  * distance
            maxi = max(result, maxi)
            
            if height[l] < height[r] {
                l += 1
            } else {
                r -= 1
            }
        }
        
        return maxi
    }
}

func maxAreaEf(_ height: [Int]) -> Int {
    var maxi = 0
    var l = 0
    var r = height.count - 1
    while l < r {
        var distance = r - l
        let result = min(height[l], height[r])  * distance
        maxi = max(result, maxi)
        
        if height[l] < height[r] {
            l += 1
        } else {
            r -= 1
        }
    }
    
    return maxi
}

//maxAreaEf([4,3,2,1,4])

// convert Int to Roman Numeral strings
// Hint:
class SolutionRoman {
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

                for index in 0..<divisor {
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
