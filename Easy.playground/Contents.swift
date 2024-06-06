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

class FindIndexOfFirstSolution {
  /*
   using the length of the needle as range into the haystack, and a start index from zero. using a while loop, create a range in the haystack string between start index of zero and needle length. Then increment the start and needlelength by 1.
   
   if the sub string is equal to to the needle, return the current start index.
   */
    func strStr(_ haystack: String, _ needle: String) -> Int {

        var needleLength = needle.count - 1

        var start = 0

      while needleLength < haystack.count {
        var sub = haystack[haystack.index(haystack.startIndex, offsetBy: start)...haystack.index(haystack.startIndex, offsetBy: needleLength)]
        
        if needle == String(sub) {
          return start
        }
        start += 1
        needleLength += 1
        
      }
      
      
      
      
      return -1
        
    }
}

let varued = "padbutpad"
let needle = "sad"

//var sub = varued[varued.index(varued.startIndex, offsetBy: 6)...varued.index(varued.startIndex, offsetBy: 8)]
//
//print(String(sub))

//let test = FindIndexOfFirstSolution()

//print(test.strStr(varued, needle))


// learning sliding window technique

func findSubArraysThatAddUpTo(target:Int, _ nums:[Int]) -> [[Int]] {
  var left = 0
  var right = 0
  var runningSum = 0
  var result:[[Int]] = []
  
  while right < nums.count  {
    
    if target < nums[left...right].reduce(0, +) {
      left += 1
      
    } else if target > nums[left...right].reduce(0, +) {
      right += 1
      
    } else {
      result.append(Array(nums[left...right]))
      right += 1
    }
    
  }
  
  return result
}

print(findSubArraysThatAddUpTo(target: 9, [9,8,7,6,5,4,3,2,1]))



class SearchInsertSolution {
  /*
   the solution to this problem lies on the knowledge of
   binary search which has a worst case of O(log N) time
   note: mid = left + (right - left) / 2
   while left <=  right
   */
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var modi = nums

        if !modi.contains(target) {
            modi.append(target)
            modi.sort(by: <)
            print(modi)
        }

    var left = 0
    var right = modi.count - 1
    var result = 0

    while left <= right {
        let mid = left + (right - left) / 2
        
        if modi[mid] == target {
            result = mid
            return result
        } else if modi[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

 return result
        //return binarySearch(modi, target)

    }


func binarySearch(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    var result = 0

    while left <= right {
        let mid = left + (right - left) / 2
        
        if nums[mid] == target {
            result = mid
            return mid
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    return result
}
}

/*
 Given an array of integers, find the maximum sum sub-array of required size
 
 ex: [-1, 2, 3, 1, -3, 2] sub-array size: 2
 */

func maximumSumGivenRequired(size: Int, nums: [Int]) -> Int {
  // brute-force approach
  // with time complexity of O(n)
  // space complexity of O(n) which won't scale for really large array inputs
  var dict:[Int: [Int]] = [:]
  var maxKey = Int.min
  
  for index in 0..<nums.count {
    var first = nums[index]
    if index + 1 < nums.count {
      var second = nums[index + 1]
      dict[first + second] = Array(nums[index...index + 1])
    }
  }
  
  
  for (key,value) in dict {
    maxKey = max(maxKey, key)
  }
  
  return maxKey
}


//print(maximumSumGivenRequired(size: 2, nums: [-1, 2, 3, 1, -3, 2]))


func maximumSumGivenRequiredEff(size: Int, nums: [Int]) -> Int {
  // using sliding window technique
  //space complexity of O(1) which is constant even for really large array inputs
  
  var first = 0
  var second = 1
  var maxKey = Int.min
  
  while second < nums.count {
    maxKey = max(maxKey, nums[first] + nums[second])
    first += 1
    second += 1
  }
  
  return maxKey
}

//print(maximumSumGivenRequiredEff(size: 2, nums: [-1, 2, 3, 1, -3, 2]))


/*
 Medium difficulty, given an array of positive integers, find sub-arrays that add-up
 to a given number.
 */

func findSubArraysThatAddUpTo(target: Int, nums:[Int]) -> [[Int]] {
  /*
   This approach is a brute force approach. And has a poor time complexity of O(n^2)
   and space complexity of O(n)
   */
  var result:[[Int]] = []
  
  for i in 0..<nums.count {
    for j in i+1..<nums.count {
      if target == nums[i...j].reduce(0, +) {
        result.append(Array(nums[i...j]))
      }
    }
  }
  
  return result
}


//print(findSubArraysThatAddUpTo(target: 7, [7,1,7,4,3,1,2,1,5,1]))


func findSubArraysThatAddUpToEff(target:Int, nums:[Int]) -> [[Int]] {
  /*
   This approach uses a dynamically sized sliding window to hold arrays based on if the
   sum of the array matches the target, greater than or less than.
   
   time complexity of O(n)
   space complexity of O(n)
   */
  var first = 0
  var second = 0
  var result:[[Int]] = []
  
  while second < nums.count {
    if target > nums[first...second].reduce(0,+) {
      second += 1
    } else if target < nums[first...second].reduce(0,+) {
      first += 1
    } else {
      result.append(Array(nums[first...second]))
      second += 1
    }
  }
  
  return result
}

//print(findSubArraysThatAddUpToEff(target: 7, nums: [7,1,7,4,3,1,2,1,5,1]))


// VARIANT with negative array inputs.

/*
 given an array of integers (negative, 0, positive) find the sub-arrays that add up to a target sum
 using KADANE'S ALGORITHM
*/


/*
 given an array of 0's and 1's, finding the maximum sequence of continous 1's that can be formed by flipping at most k 0's to 1's.
 
 
 */

func maxSequenceOf(flip:Int, bits:[Int]) -> Int {
  // this is brute force approach that goes through all the possible
  // sequences of 0's and 1s and finds the longest sub-sequence with 2 0s
  // time complexity is O(n^2)
  // space complexity of O(n^2)
  
   var maxKey = Int.min
  
  for i in 0..<bits.count {
    for j in i+1..<bits.count {
      var sub = Array(bits[i...j])
      
      if countOccurence(arr: sub) == flip {
        maxKey = max(maxKey, sub.count)
      }
    }
  }
  return maxKey
}

func countOccurence(arr:[Int]) -> Int {
  var count = 0
  for int in arr {
    if int == 0 {
      count += 1
    }
  }
  return count
}

//print(maxSequenceOf(flip: 2, bits: [0,1,0,1,0,0,1,1]))


func maxSequenceOfEff(flip:Int, bits:[Int]) -> Int {
  /*
   This dynamic sliding window approach uses count occurence method to keep track of the
   number of 0's if the number of zeros is less than the flips, we shrink the window from the left, if its greater, we shrink from the right. If its equal, we also shrink from the right.
   
   time complexity is O(n)
   space complexity is O(1)
   */
  var start = 0
  var end = 0
  var maxKey = 0
  
  while end < bits.count {
    var sub = Array(bits[start...end])
    if flip < countOccurence(arr: sub) {
      start += 1
    } else if flip > countOccurence(arr: sub) {
      end += 1
    } else {
      maxKey = max(maxKey, sub.count)
      end += 1
    }
  }
  
  return maxKey
}

//print(maxSequenceOfEff(flip: 2, bits: [0,1,0,1,0,0,1,1]))

// VARIANT HARD QUESTION with strings.

/*
 given a string and n characters, find the shortest substring that contains all the desired characters
 */

func shortestSubString(desire: String, input:String) -> String {
  var shortestLen = Int.max
  var shortest = ""
  
  for i in 0..<input.count {
    for j in i+1..<input.count {
      var subString = String(input[input.index(input.startIndex, offsetBy: i)...input.index(input.startIndex, offsetBy: j)])
      if let subContent = seeContains(desire: desire, sub: subString) {
        shortestLen = max(shortestLen, subContent.count)
        shortest = subContent
      }
    }
  }
  
  return shortest
}

func seeContains(desire:String, sub:String) -> String? {
  var reducer = desire.count
  
  for chr in desire {
    if sub.contains(chr) {
      reducer -= 1
    }
  }
  
  if reducer == 0 {
    return sub
  }
  return nil
}

func seeContainsCount(desire:[Character], sub:String) -> (Bool, [Character]) {
  var editable = desire
  
  for (index,chr) in desire.enumerated() {
    if sub.contains(chr) {
      editable.remove(at: index)
      return (true, editable)
    }
  }
  return (false, editable)
}



//print(shortestSubString(desire: "abc", input: "fa4chba4c"))


func shortestSubStringEff(desire: String, input:String) -> String {
  var chr = [Character]()
  
  for i in desire {
    chr.append(i)
  }
  
  var chr2 = chr
  
  var start = 0
  var end = 1
  var count = 0
  var shortestLen = Int.max
  var shortest = ""
  
  while end < input.count {
    var subString = String(input[input.index(input.startIndex, offsetBy: start)...input.index(input.startIndex, offsetBy: end)])
    var returned = seeContainsCount(desire: chr2, sub: subString)
   
    if returned.0 {
      chr2 = returned.1
      count += 1
    }
    
    if count == 3 {
      shortestLen = max(shortestLen, subString.count)
      shortest = subString
      chr2 = chr
      start += 1
      count = 0
      end = start
    } else {
      end += 1
    }
  }
  
  
  return shortest
}

print(shortestSubStringEff(desire: "abc", input: "fa4chba4c"))



class LengthOfLastWordSolution {
  /*
   I used a sliding window technique to track the last word in the string
   */
    func lengthOfLastWord1(_ s: String) -> Int {
     
     var end = s.count - 1
     var start = end

     if s.count == 1 {
        return 1
     }

     while start < s.count  {
        var subString = String(s[s.index(s.startIndex, offsetBy: start)])
        if subString != " " {
            if start == 0 {
            var subString = String(s[s.index(s.startIndex, offsetBy: start)...s.index(s.startIndex, offsetBy: end)])
            var cleanStr = subString.replacingOccurrences(of:" ", with: "")
                if cleanStr != "" {
                    return cleanStr.count
                }
            }
            
            start -= 1

        } else {

            var subString = String(s[s.index(s.startIndex, offsetBy: start)...s.index(s.startIndex, offsetBy: end)])
            var cleanStr = subString.replacingOccurrences(of:" ", with: "")
            if cleanStr != "" {
                return cleanStr.count
            }
            start -= 1
            end = start
        }

     }

     return 0
        
    }
  
  
  // Solution with faster run-time
  func lengthOfLastWord(_ s: String) -> Int {
      var count = 0
      for chr in s.reversed() {
          if chr != " " {
              count += 1
          } else if count > 0 {
              break
          }
      }

      return count
  }
}


class PlusOneSolution {
  /*
   The solution starts check from the right-most element, by checking if its a 9
   if it not, we simply add 1 to the last digit and replace that last digit
   else, we create a carry variable to hold our extra carry if sum is 10 and loop from that last 9, within the loop if sum is 10, set carry to 1 and set 0 to the current index, if sum is less than 10, we simply add 1 to the last digit and replace that last digit and return from the loop.
   
      if we have gotten to the first and carry value is 1, insert it as the first value.
   */
    func plusOne(_ digits: [Int]) -> [Int] {
        var temp = digits
        var i  = temp.count - 1

        if let last = temp.last {
            if last == 9 {
                    var carry = 0
                    while i != -1 {
                    if temp[i] + 1  == 10 {
                        carry = 1
                        temp[i] = 0
                    } else if temp[i] + 1  < 10 {
                        temp[i] = temp[i] + 1
                        carry = 0
                        return temp
                    }
                    i -= 1
                    if  i == -1 && carry == 1 {
                        temp.insert(carry, at: 0)
                    }
             }
                
            } else {
                temp[temp.count - 1] = last + 1
            }
        }

        return temp
    }
}


class AddBinarySolution {
    func addBinary(_ a: String, _ b: String) -> String {
      /*
       My solution uses basicall tries to add the two numbers using their right-most
       1s. so there are 3 cases to keep into consideration:
       1. when both a and b are equal in length
       2. when a is longer
       3. when b is longer
       created a carry variable
       So for case 1:
                 i used the first while loop to check both string from the right-most, if the sum of the carry and first character in a and first character in b is 2 (we carry 1, and append 0), is 3 (we carry 1, and append 1), is 1 (we carry 0, and append 1)
                 and we add an else condition to check if sum is 0 (we carry 0, and append 0) or if sum is 1 (we carry 0, and append 1)
                 
                 then we check that loop has gotten to the end of both string and carry value is 1
                 and simply append 1.
       case 2:
            if string A is longer
            i continue moving my loop from rigth to left in another while loop,
            and if sum of carry and next character bit is greater-than 1 (we carry 1, and append 0)
            and if sum of carry and next character bit is 0  (we carry 0, and append 0)
            else we simply (we carry 0, and append 1)
       
              then we check that loop has gotten to the string and carry value is 1
              and simply append 1.
       case 3:
             if string B is longer
             same as case 2.
       
       */

        var i = a.count - 1
        var j = b.count - 1
        var result = ""
        var carry = 0
        while i != -1 && j != -1 {
            var chrA = Int(String(a[a.index(a.startIndex, offsetBy: i)])) ?? 0
            var chrB = Int(String(b[b.index(b.startIndex, offsetBy: j)])) ?? 0

            if carry + chrA + chrB == 2 {
                carry = 1
                result += "0"
                
            } else if carry + chrA + chrB == 3 {
                carry = 1
                result += "1"
            }
             else if carry + chrA + chrB == 1 {
                carry  = 0
                result += "1"
            }
             else {
                carry = 0
                if chrA == 0 && chrB == 0 {
                    result += "0"
                }else {
                    result += "1"
                }
            }

            i -= 1
            j -= 1

            if i == -1 && j == -1 && carry == 1 {
                    result += "1"
            }
        }

        while i != -1 {
            var chrA = Int(String(a[a.index(a.startIndex, offsetBy: i)])) ?? 0
            if carry + chrA > 1 {
                carry = 1
                result += "0"
                
            } else if carry + chrA == 0 {
                carry = 0
                result += "0"
            }
            else {
                carry = 0
                result += "1"
            }

            i -= 1

            if i == -1 && carry == 1 {
                    result += "1"
            }
        }

        while j != -1 {
            var chrB = Int(String(b[b.index(b.startIndex, offsetBy: j)])) ?? 0
            if carry + chrB > 1 {
                carry = 1
                result += "0"
                
            } else if carry + chrB == 0 {
                carry = 0
                result += "0"
            }
            else {
                carry = 0
                result += "1"
            }

            j -= 1

            if j == -1 && carry == 1 {
                    result += "1"
            }
        }



        return String(result.reversed())
        
    }
}


class ClimbStairsSolution {
  /*
   The naive solution to this problem uses recursion to find the possible ways of climbing the stairs. Starting with a base case of n == 1, and n == 2.
   
   Unfortunately the naive approach blows up your stack memory when n becomes really large. So I applied memoization to cache results that have been previously computed, and access them as needed.
   */
    var memo:[Int:Int] = [Int:Int]()
    func climbStairs(_ n: Int) -> Int {
        if let val = memo[n] {
            return val
        }

        if n == 1 {
            memo[n] = 1
            return 1
        } else if n == 2 {
            memo[n] = 2
            return 2
        } else {
           memo[n] = climbStairs(n - 1) + climbStairs(n - 2)
           return climbStairs(n - 1) + climbStairs(n - 2)
        }
    }
  
  /*
   Using a bottom-up iterative approach approach with a better runtime, no need to maintain a high call stack
   */
  func climbStairsEff(_ n: Int) -> Int {
      if n == 1 {
          return 1
      }
      if n == 2 {
          return 2
      }

      var dp = [Int](repeating: 0, count: n + 1)
      dp[1] = 1
      dp[2] = 2
      
      for i in 3...n {
          dp[i] = dp[i - 1] + dp[i - 2]
      }
      
      return dp[n]
  }
}


class MySqrtSolution {
    /*
    using the Babylonian method that basically resilies on the formular
     = (Intial + (Double(input) / Initial)) / 2
     and using a threshold of 10^-6 == 0.000001, we continuosly find a value that is
     less than than the threshold; by finding the abs value of the initial and the next initial value.
    */
    func mySqrt(_ x: Int) -> Int {
        var threshold = 0.000001
        var initial = 1.0

        while true {
            var initialx  = initial
            initial =  (initialx + (Double(x) / initialx)) / 2
            let dob = Double(abs(initial - initialx))
            if dob < threshold {
                return Int(initial)
            }
        }

        
    }

}


class DeleteDuplicatesSolution {
  /*
   used a while loop to move through the linked list.
   and within it, I check if the current value is equal to the next value, if it is, store address to the next element and set next address of current element to nil,
   
   if it is not, update the address of the next element to current value of the next
   then move current value to the next
   and move next to next pointer.
   */
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var current = head
        var next = current?.next
        while next != nil {
            if current?.val == next?.val {
                next = next?.next
                current?.next = nil
            } else {
                current?.next = next
                current = current?.next
                next = next?.next
            }
            
            
        }
        

        return head
        
    }
}


class MergeTwoSortedArraySolution {
  /*
   The goal is to merge to sorted arrays.
   So given that for the longer array, we already have the empty
   location marked with zeros, we simply have to loop through the shorter arrary, inserting them into the empty spaces with the longer array which happens to begin from Index m.
   When the insertion is complete, we perform a standard merge sort of the longer array in ascending order.
   */
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var j = m

        for index in 0..<nums2.count {
            nums1[j] = nums2[index]
            j += 1
        }
       nums1 = nums1.sorted(by: <)
    }
}



  //Definition for a binary tree node.
  public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init() { self.val = 0; self.left = nil; self.right = nil; }
      public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
      public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
          self.val = val
          self.left = left
          self.right = right
      }
  }
 
class InorderTraversalSolution {
  /*
   InorderTraversal of a Binary Tree, traverses the tree by visiting the left node left, then the node, then the right node.
   Our task was to get all the values in a array, all sorted in ascending order.
   so I recursively collected all lower values returned by the left tree, then appended the value in the node,
   and collected all the higer values in the right tree.
   */
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        if root != nil {
           result.append(contentsOf: inorderTraversal(root?.left))
            if let node = root {
                result.append(node.val)
            }
            result.append(contentsOf: inorderTraversal(root?.right))
        }
        
        return result
    }
}

// doing some learning of binary search trees



class IsSymmetricSolution {
  /*
   To determine if a binary tree is symmetric,
   i had to pass the 2 copies of the target tree in other to properly compare the left node of copy A against the right node of copy B and vice-versa.
   
   then right and check also if both nodes are nil
   
   if either is nil, the tree is not symmetric
   
   if the val on the left and right nodes are equal, and recursive calls to right and left, and left and right
   */
    func isSymmetric(_ root: TreeNode?) -> Bool {
        isMirror(root, root)
    }
    
  // send down copy of main tree, as leftTree and rightTree
  // compare leftNodes on leftTree with rightNodes on rightTree.
  // then compare rightNodes on leftTree with leftNodes on rightTree
    func isMirror(_ leftTree:TreeNode?, _ rightTree:TreeNode?) -> Bool {
        if leftTree == nil && rightTree == nil {
            return true
        }
        
        if rightTree == nil || rightTree == nil {
            return false
        }
        
       return leftTree?.val ==  rightTree?.val && isMirror(leftTree?.left, rightTree?.right) && isMirror(leftTree?.right, rightTree?.left)
    }
}


class SortedArrayToBSTSolution {
    var root: TreeNode?
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        
        for num in nums {
            insert(num)
        }
        return root
    }

    public func insert(_ val: Int) {
        root = insertNode(root, val: val)
    }

    private func insertNode(_ node: TreeNode?, val: Int) -> TreeNode? {
        if node == nil {
            return TreeNode(val)
        }

        if val < node!.val {
            node?.left = insertNode(node!.left, val: val)
        } else if val > node!.val {
            node?.right = insertNode(node!.right, val: val)
        }

        // Update height
        // Check balance factor
        let balanceFactor = balanceFactor(of: node)

        // Balance the tree if needed
        if balanceFactor > 1 && val < node!.left!.val {
            return rotateRight(node)
        } else if balanceFactor < -1 && val > node!.right!.val {
            return rotateLeft(node)
        } else if balanceFactor > 1 && val > node!.left!.val {
            node?.left = rotateLeft(node!.left)
            return rotateRight(node)
        } else if balanceFactor < -1 && val < node!.right!.val {
            node?.right = rotateRight(node!.right)
            return rotateLeft(node)
        }

        return node
    }

    private func height(of node: TreeNode?) -> Int {
        if node == nil {
            return 0
        } else {
            return max(height(of: node?.left), height(of: node?.right)) + 1
        }
    }

    private func balanceFactor(of node: TreeNode?) -> Int {
        return height(of: node?.left) - height(of: node?.right)
    }

    private func rotateLeft(_ node: TreeNode?) -> TreeNode? {
        let temp = node?.right
        node?.right = temp?.left
        temp?.left = node
        return temp
    }

    private func rotateRight(_ node: TreeNode?) -> TreeNode? {
        let temp = node?.left
        node?.left = temp?.right
        temp?.right = node
        return temp
    }
}


class AVLTrees {
  var rootNode:TreeNode?
  
  func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
      for num in nums {
          insert(num)
      }
      return rootNode
  }

  public func insert(_ val: Int) {
    rootNode = addNode(rootNode,val)
  }
  
  func addNode(_ node: TreeNode?, _ value: Int) -> TreeNode? {
    if node == nil {
      return TreeNode(value)
    }
    
    if let val = rootNode?.val, val < value {
      node?.right = addNode(node?.right, value)
    } else {
      node?.left = addNode(node?.left, value)
    }
    
    let balaceFactor = heightFactor(node)
    
    if balaceFactor > 1 && value < node!.left!.val {
      return rotateRight(node)
    } else if balaceFactor < -1 && value > node!.right!.val {
      return rotateLeft(node)
    } else if balaceFactor > 1 && value > node!.left!.val {
      node?.left = rotateLeft(node?.left)
      return rotateRight(node)
    } else if balaceFactor < -1 && value < node!.right!.val {
      node?.right = rotateRight(node?.right)
      return rotateLeft(node)
    }
    
    return node
  }
  
  
  func heightFactor(_ node: TreeNode?) -> Int {
    height(node?.left) - height(node?.right)
  }
  
  func height(_ node: TreeNode?) -> Int {
    if node == nil {
      return 0
    } else {
      return max(height(node?.left), height(node?.right)) + 1
    }
  }
  
  func rotateLeft(_ node: TreeNode?) -> TreeNode? {
    var temp = node?.right
    node?.right = temp?.left
    temp?.left = node
    return temp
  }
  
  func rotateRight(_ node: TreeNode?) -> TreeNode? {
    var temp = node?.left
    node?.left = temp?.right
    temp?.right = node
    return temp
  }
}


class IsBalancedSolution {
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }

        let heightRight = heightOfTree(root?.right)
        let heightLeft = heightOfTree(root?.left)
        let height = heightLeft - heightRight
        if height == 1 || height == -1 || height == 0 {
            return isBalanced(root?.left) && isBalanced(root?.right)
        } else {
            return false
        }
    }

    func heightOfTree(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        } else {
            return max(heightOfTree(root?.left), heightOfTree(root?.right)) + 1
        }
    }
}

class HasPathSumSolution {
  /* This problem uses DFS to find the if integer values in existing path in a tree sum up to a target
   */
  
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        var target = targetSum

        guard root != nil else {
            return false
        }

         if root?.left == nil && root?.right == nil {
           return target - root!.val == 0
        }

        return hasPathSum(root?.left, getReminant(root,target)!) || hasPathSum(root?.right, getReminant(root,target)!)
    }

    func getReminant(_ root:TreeNode?, _ target: Int) -> Int? {
        
        if let value = root?.val {
            return target - value
        }
        return nil
        
    }
}

class GenerateSolution {
  /*
   In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
   */
  func generate(_ numRows: Int) -> [[Int]] {
    var result = [[Int]]()
    var guider = [1,1]
    
    if numRows == 1 {
      result.append([1])
      return result
    }
    
    if numRows == 2 {
      result.append([1])
      result.append([1,1])
      return result
    }
    
    for i in 1...numRows {
      if i == 1 {
        result.append([1])
      }else if i == 2 {
        result.append([1,1])
      } else {
        var lastValues = result.last!
        for index in 0..<lastValues.count {
          if index + 1 < lastValues.count {
            var sum = lastValues[index] + lastValues[index + 1]
            guider.insert(sum, at: 1)
          }
        }
        result.append(guider)
        guider = [1,1]
      }
    }
    return result
  }
}


func levelOrderTraverse(_ root: TreeNode?) {
  var queue = [TreeNode?]()
  
  if let rootNode = root {
    queue.append(rootNode)
    
    while !queue.isEmpty {
      let dequedNode = queue.removeFirst()
      if let visit = dequedNode?.val {
        print("\(visit)")
      }
      queue.append(dequedNode?.left)
      queue.append(dequedNode?.right)
    }
  }
  
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)

root.left?.left = TreeNode(4)
root.left?.right = TreeNode(5)

root.right?.left = TreeNode(6)
root.right?.right = TreeNode(7)


//levelOrderTraverse(root)


class GetRowSolution {
  /*
   Get a specific row of a pascal triangle
   */
  func getRow(_ rowIndex: Int) -> [Int] {
      var result = generate(rowIndex)
      return result[rowIndex]!
  }

 func generate(_ numRows: Int) -> [Int: [Int]] {
    var result = [Int: [Int]]()
    var guider = [1,1]
    if numRows == 0 {
      result[numRows] = [1]
      return result
    }
    
    if numRows == 1 {
      result[numRows] = [1,1]
      return result
    }
    
    for i in 0...numRows {
      if i == 0 {
        result[i] = [1]
      }else if i == 1 {
        result[i] = [1,1]
      } else {
        var lastValues = result[i - 1]!
        for index in 0..<lastValues.count {
          if index + 1 < lastValues.count {
            var sum = lastValues[index] + lastValues[index + 1]
            guider.insert(sum, at: 1)
          }
        }
        result[i] = guider
        guider = [1,1]
      }
    }
    return result
  }
}

var adjancenyList = [
  0:[1,2],
  1:[0,3,4],
  2:[0],
  3:[1],
  4:[1,5],
  5:[4]
]

/*
 Recursive DFS using recursion
 */

func DFS(graph:[Int:[Int]], startNode:Int, register:inout [Bool]){
  if !register[startNode] {
    register[startNode] = true
  }else{
    return
  }
  
  
  guard let neighbors = graph[startNode] else { return }
  
  for node in neighbors {
    if !register[node] {
      DFS(graph: graph, startNode: node, register: &register)
    }
  }
  
}

var visited = [false,false,false,false,false,false]

//DFS(graph: adjancenyList, startNode: 0, register: &visited)
//print(visited)


/*
 Iterative Depth first Search Algorithm using a Stack
 */
func DFS2(graph:[Int:[Int]], startNode:Int) -> [Bool] {
  var visited = Array(repeating: false, count: graph.count)
  var stack = [Int]()
  stack.append(startNode)
  
  while !stack.isEmpty {
    var examined = stack.removeLast()
    
    if !visited[examined]{
      visited[examined] = true
    }
    
    var connected = graph[examined]!
    
    for neighbor in connected {
      if !visited[neighbor] {
        stack.append(neighbor)
      }
    }
    
  }
  
  return visited
}

//print(DFS2(graph: adjancenyList, startNode: 0))


// find the shortest path between two nodes

func findShortest(graph:[Int:[Int]], startNode:Int, endNode: Int) -> [Int] {
  var prev = solve(startNode:startNode, graph:graph)
  //reconstruct(startNode,endNode,prev)
  return reconstruct(startNode,endNode,prev)
}

func solve(startNode:Int, graph:[Int:[Int]]) -> [Int] {
  var queue = [Int]()
  var prev = Array(repeating: 0, count: graph.count)
  var visited = Array(repeating: false, count: graph.count)
  
  queue.append(startNode)
  
  while !queue.isEmpty {
    var poped = queue.removeFirst()
    
    if !visited[poped] {
      visited[poped] = true
    }
    
    var neigh = graph[poped]!
    
    for neighbor in neigh {
      if !visited[neighbor] {
        queue.append(neighbor)
        visited[neighbor] = true
        prev[neighbor] = poped
      }
    }
    
  }
  return prev
}

func reconstruct(_ startNode:Int,_ endNode:Int, _ prev:[Int]) -> [Int] {
  var path = [Int]()
  var at = endNode
  print(prev)
  while(at != 0) {
    at = prev[at]
    path.append(at)
  }
  
  path.reverse()
  
  if path[0] == startNode {
    return path
  }
  
  return []
}


print(findShortest(graph: adjancenyList, startNode: 0, endNode: 5))


/*
 Best time to buy stock solution
 */

class MaxProfitSolution {

  /*
   O(n) solution keeps track of the minPrice
   and finds the max profit as the running max of currPrice - minPrice
   */
 func maxProfit(_ prices: [Int]) -> Int {
        
        var maxProfit = 0
        var minPrice = prices[0]

        for i in 0..<prices.count {
            minPrice = min(prices[i], minPrice)
            maxProfit = max(prices[i] - minPrice, maxProfit)
        }

        return maxProfit
    }



/*
 The first approach is O(n^2) with two loops
 going through all the possibilites of max of sellPrice - currPrice
 */
    /*func maxProfit(_ prices: [Int]) -> Int {
        
        var maxProfit = 0

        for i in 0..<prices.count {
            var costPrice = prices[i]

            for j in i+1..<prices.count {
                var sellPrice = prices[j]

                maxProfit = max(sellPrice - costPrice, maxProfit)
            }
        }

        return maxProfit
    }*/
}
