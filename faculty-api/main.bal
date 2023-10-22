import ballerina/http;

service /lecturers on new http:Listener(1337) {

  resource function get lect() returns LectureEntry[] {
        return lectureTable.toArray();
    }
    resource function post lect(@http:Payload LectureEntry[] lectureEntries) 
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

    resource function get lect/[string s_num]() returns LectureEntry|InvalidsNumCodeError {
        LectureEntry? lectureEntry = lectureTable[s_num];
        if lectureEntry is () {
            return {
                body: {
                    errmsg: string `Invalid Studen number: ${s_num}`
                }
            };
        }
        return lectureEntry;
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
    {s_num: "123", name: "Job", course: "Math", Lectinfo: "cool", Officenum: 146084},
    {s_num: "321", name: "Sam", course: "Greek", Lectinfo: "bad", Officenum: 568637},
    {s_num: "101", name: "Bill", course: "Math", Lectinfo: "meh", Officenum: 4389227}
];

public type ConflictingsNumCodesError record {|
    *http:Conflict;
    ErrorMsg body;
|};
public type InvalidsNumCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};
public type ErrorMsg record {|
    string errmsg;
|};
public type NotFoundError record {|
    *http:NotFound;
    ErrorMsg body;
|};
public type ConflictError record {|
    string errmsg;
|};
