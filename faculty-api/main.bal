import ballerina/http;

service /lecturers on new http:Listener(1337) {

    resource function post addLect(@http:Payload LectureEntry[] lectureEntries) 
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
    resource function get allLect() returns string {
        return "Hi!";
    }
    resource function put upLect() returns string {
        return "Hi!";
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
    string country;
    decimal cases;
    decimal deaths;
    decimal recovered;
    decimal active;
|};