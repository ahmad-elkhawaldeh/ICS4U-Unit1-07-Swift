//
// The "Marks" program it marks assignments and 
// creates csv file with it.
//
// @author  Ahmad El-khawaldeh
// @version 1.0
// @since   2021-12-04
//


import Foundation

func generateMarks(arrayOfStudents: [String],
                   arrayOfAssignments: [String]) throws -> [[String]] {
    // This is the generate Marks function.
    let stuNum: Int = arrayOfStudents.count
    let stuAss: Int = arrayOfAssignments.count

    var markArray = [[String]]()

    for _ in 0...(stuNum) {
    markArray.append([])
    }
    markArray[0].append("-")

    for counter in 0...(stuAss - 1) {
        markArray[0].append(arrayOfAssignments[counter])
    }

    var counter2: Int = 1
    for counter in 0...(stuNum - 1) {
        markArray[counter2].append(arrayOfStudents[counter])
        counter2 += 1
    }

    for counter in 1...(stuNum) {
        for _ in 1...(stuAss) {
          // for actual Gaussian would have to import GameplayKit
          // it only works in a Mac machine though.
          let mark: String = String(Int.random(in: 65...85))
          markArray[counter].append(mark)
        }
    }

    print(markArray)

    return markArray
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask)
    return paths[0]
}

// get arguments
let input = CommandLine.arguments
let file1 = input[1]
let file2 = input[2]
// this is the file. we will write to and read from it
var array1: [String] = []
var array2: [String] = []
// FileManager is the way to write and read files in swift
if let dir1 = FileManager.default.urls(for: .documentDirectory,
                                      in: .userDomainMask).first {
    let fileURL1 = dir1.appendingPathComponent(file1)
    do {
        // how to read the file.
        let text = try String(contentsOf: fileURL1, encoding: .utf8)
        array1 = text.components(separatedBy: .newlines)
        array1.remove(at: array1.count-1)
    } catch {print("error")}
} else { print("error2") }

if let dir2 = FileManager.default.urls(for: .documentDirectory,
                                      in: .userDomainMask).first {
    let fileURL2 = dir2.appendingPathComponent(file2)
    do {
        // how to read the file.
        let text = try String(contentsOf: fileURL2, encoding: .utf8)
        array2 = text.components(separatedBy: .newlines)
        array2.remove(at: array2.count-1)
    } catch {print("error")}
} else { print("error2") }

print(array1)
print(array2)

let marksArray: [[String]] = try generateMarks(arrayOfStudents: array1,
                                               arrayOfAssignments: array2)

let filename = getDocumentsDirectory().appendingPathComponent("marks.csv")

var writingArray: [String] = []
for counter in 0...(marksArray.count - 1) {
     writingArray.append(marksArray[counter].joined(separator: ","))
}

let str: String = writingArray.joined(separator: "\n")

do {
    try str.write(to: filename,
                    atomically: true,
                    encoding: String.Encoding.utf8)
} catch {
print("error")
}

print("\nDone.\n")
