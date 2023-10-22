import ballerina/http;

service /lecturers on new http:Listener(1337) {

  resource function get Lect() returns LectureEntry[] {
        return lectureTable.toArray();
    }
    resource function post Lect(@http:Payload LectureEntry[] lectureEntries) 
    returns LectureEntry[]|ConflictingsNumCodesError  {
         string[] conflictingsNum = from LectureEntry lectureEntry in lectureEntries
            where lectureTable.hasKey(lectureEntry.s_num)
            select lectureEntry.s_num;

        if conflictingsNum.length() > 0 {
            return {
                body: {
                    errmsg: string:'join(" ", "Conflicting Staff Numbers:", ...conflictingsNum)
                }
            };
        } else {
            lectureEntries.forEach(lectureEntry => lectureTable.add(lectureEntry));
            return lectureEntries;
        }
    }
    resource function put lect/[string sNum](@http:Payload LectureEntry updatedLectureEntry) 
        returns LectureEntry|NotFoundError|ConflictError {
    // Check if the entry exists
    if (lectureTable.hasKey(sNum)) {
        // Update the entry
        lectureTable[sNum] = updatedLectureEntry;
        // Return the updated entry
        return updatedLectureEntry;
    } else {
        // If the entry does not exist, return a not found error
        return { body: { errmsg: "Lecture Entry not found for staff number: " + sNum }};
    }
}

    resource function get lectInfo() returns string {
        return "Hi!";
    }
    resource function delete sNum() returns string {
        return "Hi!";
    }
    resource function get cour() returns string {
        return "Hi!";
    }
    resource function get office() returns string {
        return "Hi!";
    }

}
    public type LectureEntry record {|
    readonly string s_num;
    string name;
    string course;
    string Lectinfo;
    decimal Officenum;
|};

public final table<LectureEntry> key(s_num) lectureTable = table [
    {s_num: "AFG", country: "Afghanistan", cases: 159303, deaths: 7386, recovered: 146084, active: 5833},
    {s_num: "SL", country: "Sri Lanka", cases: 598536, deaths: 15243, recovered: 568637, active: 14656},
    {s_num: "US", country: "USA", cases: 69808350, deaths: 880976, recovered: 43892277, active: 25035097}
];