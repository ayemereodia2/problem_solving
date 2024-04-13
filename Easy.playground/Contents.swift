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


func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var remainingFuel = 0
        var startIndex = -1
    
        for (index, costValue) in cost.enumerated() {
            let totalFuel = (remainingFuel + gas[index])
            if totalFuel >= costValue {
                
                remainingFuel = totalFuel - costValue
                if index == (cost.count - 1) && remainingFuel >= 0 {
                    return startIndex
                }

            } else {
                continue
            }
            startIndex = index
        }
    
    return -1
}
canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2])//2,3,4
//canCompleteCircuit([2,3,4], [3,4,3])

let ar = [2,4,5]

print(ar.min())


class TwoSumSolution {
    /*
    This O(n) solution contains a different approaches to the two sum problem.
    The optimized solution is different from the popular dictionary approach.
    Even though I am using a HashMap aka dictionary, I am asking two important question within my loop:
        a. after finding the other half of my array, is the next item in the array equal to this half? if it is, thats the happy path return the index and index + 1.
        b. if the half is not it, use the half as the key to a dictionary along with
        the current value and index.
        c. then we have to keep checking the next item in array if it has been encountered before.

    */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict:[Int:(Int,Int)] = [:]
        var result:[Int] = []

        for (index,current) in nums.enumerated() {
            var half = target - current
            var nextIndex = index + 1
            if nextIndex < nums.count {
                if let val = dict[nums[nextIndex]] {
                    result.append(val.1)
                    result.append(nextIndex)
                    return result
                }
                else if half  == nums[nextIndex]   {
                    result.append(nextIndex)
                    result.append(index)
                    return result
                } else {
                    dict[half] = (current, index)
                }
            }

        }

        /*
        O(n ^ 2) SOLUTION
        for (index,item) in nums.enumerated() {
            dict[index] = item
        }

        for (index,value) in nums.enumerated() {
            let diff = target - value
            if let val = getKey(index:index,value:diff,dict:dict) {
                result.append(val)
                result.append(index)
                return result
            }
              
        }*/
        
/*
O(n ^ 2) SOLUTION
        for (indexx,x) in nums.enumerated() { //n
            for (indexy, y) in nums.enumerated() { // n -1
                if x + y == target && indexy > indexx {
                    result.append(indexx)
                    result.append(indexy)
                    return result
                }
            }
        }
*/
        return result
    }

    func getKey(index:Int, value: Int, dict: [Int: Int]) -> Int? {
    for (key, dictValue) in dict {
        if dictValue == value &&  key != index {
            return key
        }
    }
    return nil // Value not found in dictionary
 }
}

class PalindromeSolution {
  
  // improved solution
  func isPalindrome(_ x: Int) -> Bool {
          if x < 0 {
              return false
          }
          
          var original = x
          var reversed = 0
          
          while original > 0 {
              let digit = original % 10
              reversed = reversed * 10 + digit
              original /= 10
          }
          
          return x == reversed
    }
  
    func isPalindromeY(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }

        if x == 0 {
            return true
        }

        let newNum = splitNumber(x)
        return isPal(newNum)
    }


    func splitNumber(_ num: Int) -> [Int] {
    
        var remnant = num
        var power = 0
        var resultArray = [Int]()
        
        while remnant > 0 {
        let result = remnant % 10
        resultArray.append(result)
        remnant = remnant / 10 // Divide by 10 to remove the last digit
        }
        
        return resultArray.reversed()
    }


    func isPal(_ arr: [Int]) -> Bool {
        var x = 0
        var y = arr.count - 1
        let mid = arr.count / 2

        if arr.count == 1 {
            return true
        }

        while(arr[x] == arr[y] && x <= mid && y >= mid) {
            x += 1
            y -= 1
            if x == mid && arr[x] == arr[y] {
                return true
            }
        }

        return false
    }
}


class RomanToIntSolution {
    func romanToInt(_ s: String) -> Int {
        let dict:[Character:Int] = ["I":1, "V":5,"X":10,"L":50,"C":100,"D":500,"M":1000]
        let special:[String:Int] = ["IV":4, "IX":9, "XL":40,"XC":90,"CD":400,"CM":900]
        var seen:[Character] = []
        var total = 0
        var index = 0

        

        for (index,chr) in s.enumerated() {
            if s.count == 1 {
              if let singleValue = dict[chr] {
                 return singleValue
               }
            }
                var strValue = s[s.index(s.startIndex, offsetBy: index)]

                if index + 1 < s.count {
                    var strNxtValue = s[s.index(s.startIndex, offsetBy: index + 1)]
                    
                    if let val = dict[strValue], let val2 = dict[strNxtValue] {
                        if val > val2 && !seen.contains(chr) {
                            total += val
                             seen.append(strValue)
                        } else if val < val2 && !seen.contains(chr) {
                            let merge = String(strValue) + String(strNxtValue)
                            if let unique = special[merge] {
                                total += unique
                            }
                            seen.append(strNxtValue)
                        }
                        else if val == val2 {
                            total += val
                        }

                        
                    }
                    
                } else {
                    var lastValue = s[s.index(s.startIndex, offsetBy: index)]
                    var secondToLast = s[s.index(s.startIndex, offsetBy: index - 1)]
                    if let lastV = dict[strValue], let secondToV = dict[secondToLast] {
                        if lastV < secondToV && !seen.contains(lastValue){
                            total += lastV
                        } else if lastV == secondToV {
                            total += lastV
                        }
                        
                    }
                }
            
        }

        return total
    }
}


class LongestCommonPrefixSolution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 1 {
            return strs[0]
        }

        var longest = ""
        var longestStr = 0
        for (index,str) in strs.enumerated() {
            if index + 1 == 1 {
                longest = commonPreFix(strs[index], strs[index + 1])
                
            } else {
                longest = commonPreFix(longest, strs[index])
            }
        }
        return longest
    }


    func commonPreFix(_ s1:String, _ s2:String) -> String {
        var i = 0
        var j = 0
        var strBuild = ""

        while(i < s1.count && j < s2.count) {
            var chr1 = s1[s1.index(s1.startIndex, offsetBy: i)]
            var chr2 = s2[s2.index(s2.startIndex, offsetBy: j)]
            if chr1 == chr2 {
                strBuild += String(chr1)
            }

            i += 1
            j += 1
        }

        return strBuild
    }
}


class isValidParenthesisSolution {
  /*
   The solution to this problem is to loop through the input string
   and use a stack DS to keep track of the open paranthesis.
   When you find a close paranthesis, first pop the top open item in your stash
   and compare it with the current item to see if its balanced then remove that open item else return false
   EDGE CASE: if the item is a single item, its not balanced.
   
   ultimately return check if the stash count is zero.
   */
    func isValid(_ s: String) -> Bool {
        var stack = [Character]()
        
        for chr in s {
            if chr == "(" || chr == "[" || chr == "{" {
                stack.append(chr)
            }
            else {
               if let lastItem = stack.last {
                   if lastItem == "(" && chr == ")" || lastItem == "[" && chr == "]" || lastItem == "{" && chr == "}" {
                       _ = stack.removeLast()
                   }else {
                     return false
                  }
               } else {
                   return false
               }
                
            }
            
        }
        
        
        return stack.count == 0
        
    }
}



 // Definition for singly-linked list.
public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init() { self.val = 0; self.next = nil; }
  public init(_ val: Int) { self.val = val; self.next = nil; }
  public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 
class MergeTwoSortedListSolution {
    var head:ListNode?
  /*
   I created a resultant listNode
   I used a while loop to monitor 3 case:
    1. when both loops have values
    2. when only list1 have values
    3. when only list2 have values
   
    then i created a method to add to the resulting listNode
   */
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var newList1 = list1
        var newList2 = list2

        while(newList1 != nil && newList2 != nil) {

            if let node1 = newList1, let node2 = newList2 {
                if node1.val < node2.val {
                    addNode(node1)
                    newList1 = newList1?.next

                } else if node1.val == node2.val {
                    addNode(node1)
                    newList1 = newList1?.next

                } else {
                    addNode(node2)
                    newList2 = newList2?.next
                }
            }

        }

        while newList1 != nil {
            if let node1 = newList1 {
               addNode(node1)
               newList1 = newList1?.next
            }
        }


        while newList2 != nil {
            if let node2 = newList2 {
                addNode(node2)
                newList2 = newList2?.next
            }
        }
        return head

    }


    func addNode(_ node: ListNode) {
        var newNode = ListNode(node.val)
        if head == nil {
            head = newNode
        } else {
            var currentHead = head
            while currentHead?.next != nil {
                currentHead = currentHead?.next
            }
            currentHead?.next = newNode
        }
    }
}

/*
var newNode = ListNode(newList2?.val)
                if head == nil {
                    head = newNode
                    newList2 = newList2?.next
                } else {
                    var currentHead = head
                    while currentHead != nil {
                        currentHead = currentHead?.next
                    }
                    currentHead = newNode
                    newList2 = newList2?.next
                    newList1 = newList1?.next
                }
*/
